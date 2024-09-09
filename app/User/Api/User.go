package User

import (
	"github.com/gin-gonic/gin"
	"strconv"
	User "vgo/app/User/Model"
	"vgo/core/db"
	"vgo/core/middle/auth"
	"vgo/core/response"
	"vgo/core/trans"
	"vgo/core/validate"
)

// Register 注册
func Register(ctx *gin.Context) {
	var user User.User
	if err := ctx.ShouldBindJSON(&user); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}

	// 验证规则
	rules := map[string]map[string]string{
		"Phone": {
			"required": trans.Trans("手机号不能为空", ""),
		},
		"Password": {
			"required": "密码不能为空66666",
		},
	}
	// 验证
	if res, err := validate.Do(user, rules); !res {
		response.Fail(ctx, err, nil)
		return
	}

	// 插入数据
	if err := db.Con().Create(&user).Error; err != nil {
		response.Fail(ctx, "注册失败", err.Error(), nil)
		return
	}
	response.Success(ctx, "成功", user, nil)
}

// GetToken 获取token
func GetToken(ctx *gin.Context) {
	res, err := auth.GenUserToken(ctx, strconv.Itoa(12))
	if err != nil {
		response.Fail(ctx, "获取失败", nil)
	}
	response.Success(ctx, "成功", res)
}

// Setback 设置黑名单
func Setback(ctx *gin.Context) {
	back := ctx.PostForm("back")
	auth.PutApiTokenInvalidateToken(ctx, back)
	response.Success(ctx, "成功", nil)
}

// Personal 用户信息
func Personal(ctx *gin.Context) {
	userID := ctx.GetString("userID")
	response.Success(ctx, "成功", map[string]interface{}{
		"userID":  userID,
		"message": "pong",
	}, nil)
}
