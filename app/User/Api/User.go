package User

import (
	"github.com/gin-gonic/gin"
	"strconv"
	"vgo/core/middle/auth"
	"vgo/core/response"
)

// GetToken 获取token
func GetToken(ctx *gin.Context) {
	res, err := auth.GenUserToken(strconv.Itoa(12))
	if err != nil {
		response.Fail(ctx, "获取失败", nil)
	}
	response.Success(ctx, "成功", res)
}

// Setback 设置黑名单
func Setback(ctx *gin.Context) {
	back := ctx.PostForm("back")
	auth.PutApiTokenInvalidateToken(back)
	response.Success(ctx, "成功", nil)
}

// UserInfo 用户信息
func UserInfo(ctx *gin.Context) {
	userID := ctx.GetString("userID")
	response.Success(ctx, "成功", map[string]interface{}{
		"userID":  userID,
		"message": "pong",
	}, nil)
}
