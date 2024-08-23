package auth

import (
	"github.com/golang-jwt/jwt/v5"
	"time"
	"vgo/core/redis"
)

const (
	AdminTokenExpireDuration = time.Hour * 24
	UserTokenExpireDuration  = time.Hour * 1
)

var (
	AdminSecret = []byte("admin-secret")
	UserSecret  = []byte("user-secret")
	//AdminTokenBlacklist = map[string]bool{}
)

// GenAdminToken 生成后台管理用户的JWT Token
func GenAdminToken(userID, role string) (string, error) {
	claims := AdminClaims{
		UserID: userID,
		Role:   role,
		RegisteredClaims: jwt.RegisteredClaims{
			ExpiresAt: jwt.NewNumericDate(time.Now().Add(AdminTokenExpireDuration)),
			Issuer:    "admin",
		},
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	return token.SignedString(AdminSecret)
}

// PutAdminInvalidateToken 将token加入黑名单
func PutAdminInvalidateToken(tokenString string) {
	redis.Con().Set("admin_blacklist"+tokenString, tokenString, AdminTokenExpireDuration)
}

// AssertIsTokenInvalid 检查token是否在黑名单中
func AssertIsTokenInvalid(tokenString string) bool {
	val := redis.Con().Get("admin_blacklist" + tokenString)
	return val.Val() == tokenString
}

// GenUserToken 生成前台用户的JWT Token
func GenUserToken(userID string) (string, error) {
	claims := UserClaims{
		UserID: userID,
		RegisteredClaims: jwt.RegisteredClaims{
			ExpiresAt: jwt.NewNumericDate(time.Now().Add(UserTokenExpireDuration)),
			Issuer:    "user",
		},
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	return token.SignedString(UserSecret)
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

// ParseUserToken 解析前台用户的JWT Token
func ParseUserToken(tokenString string) (*UserClaims, error) {
	token, err := jwt.ParseWithClaims(tokenString, &UserClaims{}, func(token *jwt.Token) (interface{}, error) {
		return UserSecret, nil
	})
	if err != nil {
		return nil, err
	}
	if claims, ok := token.Claims.(*UserClaims); ok && token.Valid {
		return claims, nil
	}
	return nil, jwt.ErrSignatureInvalid
}
