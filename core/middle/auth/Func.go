package auth

import (
	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt/v5"
	"strconv"
	"time"
	"vgo/core/global"
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
func GenAdminToken(ctx *gin.Context, userID uint64, role []string, super int) (map[string]string, error) {
	claims := AdminClaims{
		UserID: userID,
		Role:   role,
		Super:  super,
		RegisteredClaims: jwt.RegisteredClaims{
			ExpiresAt: jwt.NewNumericDate(time.Now().Add(AdminTokenExpireDuration)),
			Issuer:    "vgo-admin",
		},
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	tokenString, _ := token.SignedString(AdminSecret)

	JwtConf := global.App.Config.JwtConf
	// 是否单设备登录
	if JwtConf.AdminSingleLogin == 1 {
		err := redis.Con().Set(ctx, "admin_token"+strconv.Itoa(int(userID)), tokenString, AdminTokenExpireDuration).Err()
		if err != nil {
			return nil, err
		}
	} else {
		err := redis.Con().LPush(ctx, "admin_token_list"+strconv.Itoa(int(userID)), tokenString).Err()
		if err != nil {
			return nil, err
		}
		err = redis.Con().Expire(ctx, "admin_token_list"+strconv.Itoa(int(userID)), AdminTokenExpireDuration).Err()
		if err != nil {
			return nil, err
		}
	}
	// 格式化时间为目标格式
	formattedTime := claims.RegisteredClaims.ExpiresAt.Time.Format("2006-01-02 15:04:05")
	return map[string]string{
		"expires_at":   formattedTime,
		"access_token": tokenString,
	}, nil
}

// DelAdminToken 删除后台管理用户的JWT Token
func DelAdminToken(ctx *gin.Context, userID uint64) error {
	// 处理多设备登录
	err := redis.Con().Del(ctx, "admin_token"+strconv.Itoa(int(userID))).Err()
	if err != nil {
		return nil
	}
	return nil
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
func PutAdminInvalidateToken(ctx *gin.Context, tokenString string) {
	//AdminTokenBlacklist[tokenString] = true // 不使用redis
	redis.Con().Set(ctx, "admin_blacklist"+tokenString, tokenString, AdminTokenExpireDuration)
}

// AssertIsTokenInvalid 检查token是否在黑名单中
func AssertIsTokenInvalid(ctx *gin.Context, tokenString string) bool {
	//return AdminTokenBlacklist[tokenString] // 不使用redis
	val := redis.Con().Get(ctx, "admin_blacklist"+tokenString)
	return val.Val() == tokenString
}

// GenUserToken 生成前台用户的JWT Token
func GenUserToken(ctx *gin.Context, userID uint64) (map[string]string, error) {
	claims := UserClaims{
		UserID: userID,
		RegisteredClaims: jwt.RegisteredClaims{
			ExpiresAt: jwt.NewNumericDate(time.Now().Add(ApiTokenExpireDuration)),
			Issuer:    "user",
		},
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	tokenString, _ := token.SignedString(ApiSecret)
	JwtConf := global.App.Config.JwtConf
	// 是否单设备登录
	if JwtConf.ApiSingleLogin == 1 {
		err := redis.Con().Set(ctx, "api_token"+strconv.Itoa(int(userID)), tokenString, ApiTokenExpireDuration).Err()
		if err != nil {
			return nil, err
		}
	} else {
		err := redis.Con().LPush(ctx, "api_token_list"+strconv.Itoa(int(userID)), tokenString).Err()
		if err != nil {
			return nil, err
		}
		err = redis.Con().Expire(ctx, "api_token_list"+strconv.Itoa(int(userID)), AdminTokenExpireDuration).Err()
		if err != nil {
			return nil, err
		}
	}
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
func PutApiTokenInvalidateToken(ctx *gin.Context, tokenString string) {
	//ApiTokenBlacklist[tokenString] = true // 不使用redis
	redis.Con().Set(ctx, "api_blacklist"+tokenString, tokenString, ApiTokenExpireDuration)
}

// AssertApiTokenIsInvalid 检查token是否在黑名单中
func AssertApiTokenIsInvalid(ctx *gin.Context, tokenString string) bool {
	//return ApiTokenBlacklist[tokenString] // 不使用redis
	val := redis.Con().Get(ctx, "api_blacklist"+tokenString)
	return val.Val() == tokenString
}
