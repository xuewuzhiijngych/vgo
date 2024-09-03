package auth

import (
	"github.com/golang-jwt/jwt/v5"
)

// AdminClaims 后台管理用户的Claims
type AdminClaims struct {
	UserID string   `json:"user_id"`
	Role   []string `json:"role"`
	Super  int      `json:"super"`
	jwt.RegisteredClaims
}

// UserClaims 前台用户的Claims
type UserClaims struct {
	UserID string `json:"user_id"`
	jwt.RegisteredClaims
}
