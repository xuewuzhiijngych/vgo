package auth

import (
	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt/v5"
	"time"
	"vgo/core/redis"
)

var (
	AdminTokenExpireDuration time.Duration
	ApiTokenExpireDuration   time.Duration
	AdminSecret              []byte
	ApiSecret                []byte
	AdminTokenBlacklist      = map[string]bool{} // 不使用redis设置黑名单时使用
	ApiTokenBlacklist        = map[string]bool{} // 不使用redis设置黑名单时使用
)

// GenAdminToken 生成后台管理用户的JWT Token
func GenAdminToken(userID, role string) (map[string]string, error) {
	claims := AdminClaims{
		UserID: userID,
		Role:   role,
		RegisteredClaims: jwt.RegisteredClaims{
			ExpiresAt: jwt.NewNumericDate(time.Now().Add(AdminTokenExpireDuration)),
			Issuer:    "admin",
		},
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	tokenString, _ := token.SignedString(AdminSecret)
	//// token放入redis----单个token有效时使用
	//err := redis.Con().Set("admin_token"+userID, tokenString, AdminTokenExpireDuration).Err()
	//if err != nil {
	//	return nil, err
	//}

	// token放入redis----多个token有效时使用
	err := redis.Con().LPush("admin_token"+userID, tokenString).Err()
	if err != nil {
		return nil, err
	}
	// 设置过期时间----多个token有效时使用
	err = redis.Con().Expire("admin_token"+userID, AdminTokenExpireDuration).Err()
	if err != nil {
		return nil, err
	}

	// 格式化时间为目标格式
	formattedTime := claims.RegisteredClaims.ExpiresAt.Time.Format("2006-01-02 15:04:05")
	return map[string]string{
		"expires_at":   formattedTime,
		"access_token": tokenString,
	}, nil
}

// DelAdminToken 删除后台管理用户的JWT Token
func DelAdminToken(ctx *gin.Context) {
	userID := ctx.GetString("userID")
	err := redis.Con().Del("admin_token" + userID).Err()
	if err != nil {
		return
	}
}

// ParseAdminToken 解析后台管理用户的JWT Token
func ParseAdminToken(tokenString string) (*AdminClaims, error) {
	token, err := jwt.ParseWithClaims(tokenString, &AdminClaims{}, func(token *jwt.Token) (interface{}, error) {
		return AdminSecret, nil
	})
	if err != nil {
		return nil, err
	}
	if claims, ok := token.Claims.(*AdminClaims); ok && token.Valid {
		return claims, nil
	}
	return nil, jwt.ErrSignatureInvalid
}

// PutAdminInvalidateToken 将token加入黑名单
func PutAdminInvalidateToken(tokenString string) {
	//AdminTokenBlacklist[tokenString] = true // 不使用redis
	redis.Con().Set("admin_blacklist"+tokenString, tokenString, AdminTokenExpireDuration)
}

// AssertIsTokenInvalid 检查token是否在黑名单中
func AssertIsTokenInvalid(tokenString string) bool {
	//return AdminTokenBlacklist[tokenString] // 不使用redis
	val := redis.Con().Get("admin_blacklist" + tokenString)
	return val.Val() == tokenString
}

// GenUserToken 生成前台用户的JWT Token
func GenUserToken(userID string) (map[string]string, error) {
	claims := UserClaims{
		UserID: userID,
		RegisteredClaims: jwt.RegisteredClaims{
			ExpiresAt: jwt.NewNumericDate(time.Now().Add(ApiTokenExpireDuration)),
			Issuer:    "user",
		},
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	tokenString, _ := token.SignedString(ApiSecret)
	// token放入redis
	err := redis.Con().Set("api_token"+userID, tokenString, ApiTokenExpireDuration).Err()
	if err != nil {
		return nil, err
	}
	//// token放入redis----多个token有效时使用
	//err := redis.Con().LPush("api_token"+userID, tokenString).Err()
	//if err != nil {
	//	return nil, err
	//}
	//// 设置过期时间----多个token有效时使用
	//err = redis.Con().Expire("api_token"+userID, ApiTokenExpireDuration).Err()
	//if err != nil {
	//	return nil, err
	//}
	// 格式化时间为目标格式
	formattedTime := claims.RegisteredClaims.ExpiresAt.Time.Format("2006-01-02 15:04:05")
	return map[string]string{
		"expires_at": formattedTime,
		"token":      tokenString,
	}, nil
}

// ParseUserToken 解析前台用户的JWT Token
func ParseUserToken(tokenString string) (*UserClaims, error) {
	token, err := jwt.ParseWithClaims(tokenString, &UserClaims{}, func(token *jwt.Token) (interface{}, error) {
		return ApiSecret, nil
	})
	if err != nil {
		return nil, err
	}
	if claims, ok := token.Claims.(*UserClaims); ok && token.Valid {
		return claims, nil
	}
	return nil, jwt.ErrSignatureInvalid
}

// PutApiTokenInvalidateToken 将token加入黑名单
func PutApiTokenInvalidateToken(tokenString string) {
	//ApiTokenBlacklist[tokenString] = true // 不使用redis
	redis.Con().Set("api_blacklist"+tokenString, tokenString, ApiTokenExpireDuration)
}

// AssertApiTokenIsInvalid 检查token是否在黑名单中
func AssertApiTokenIsInvalid(tokenString string) bool {
	//return ApiTokenBlacklist[tokenString] // 不使用redis
	val := redis.Con().Get("api_blacklist" + tokenString)
	return val.Val() == tokenString
}
