package controller

import (
	jwt "github.com/appleboy/gin-jwt/v2"
	"github.com/gin-gonic/gin"
	"vgo/core/response"
)

// Authenticator 用户身份验证逻辑
func Authenticator(c *gin.Context) (interface{}, error) {
	username := c.PostForm("username")
	password := c.PostForm("password")

	if isValidUser(username, password) {
		return "user_id", nil
	}
	return nil, jwt.ErrFailedAuthentication
}

// UserInfo 用户信息
func UserInfo(ctx *gin.Context) {
	claims := jwt.ExtractClaims(ctx)
	userID := claims["id"].(string)
	response.Success(ctx, "成功", map[string]interface{}{
		"userID":  userID,
		"message": "pong",
	}, nil)
}

// 账号密码验证逻辑
func isValidUser(username, password string) bool {
	return username == "11" && password == "11"
}
