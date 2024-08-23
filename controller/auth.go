package controller

import (
	"errors"
	"github.com/gin-gonic/gin"
	"strconv"
	"vgo/core/middle/auth"
	"vgo/core/response"
)

// Authenticator 用户身份验证逻辑
func Authenticator(c *gin.Context) (interface{}, error) {
	username := c.PostForm("username")
	password := c.PostForm("password")

	if isValidUser(username, password) {
		return "user_id", nil
	}
	return nil, errors.New("用户名或密码错误")
}

// UserInfo 用户信息
func UserInfo(ctx *gin.Context) {
	userID := ctx.GetString("userID")
	role := ctx.GetString("role")
	response.Success(ctx, "成功", map[string]interface{}{
		"userID":  userID,
		"role":    role,
		"message": "pong",
	}, nil)
}

// 账号密码验证逻辑
func isValidUser(username, password string) bool {
	return username == "11" && password == "11"
}

// GetToken 获取token
func GetToken(ctx *gin.Context) {
	token, err := auth.GenAdminToken(strconv.Itoa(10), "admin")
	if err != nil {
		response.Fail(ctx, "获取失败", nil)
	}
	response.Success(ctx, "成功", gin.H{
		"token": token,
	})
}

// Setback 设置黑名单
func Setback(ctx *gin.Context) {
	back := ctx.PostForm("back")
	auth.PutAdminInvalidateToken(back)
	response.Success(ctx, "成功", nil)
}
