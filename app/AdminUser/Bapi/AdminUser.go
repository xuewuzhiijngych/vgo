package Bapi

import (
	"github.com/gin-gonic/gin"
	"ych/vgo/internal/pkg/middleware/auth"
	"ych/vgo/pkg/response"
)

// Login 登录
func Login(ctx *gin.Context) {
	res, err := auth.GenAdminToken(ctx, 1, []string{"哈哈"}, 1)
	if err != nil {
		response.Fail(ctx, err.Error(), nil)
		return
	}
	response.Success(ctx, "登录成功", res)
}
