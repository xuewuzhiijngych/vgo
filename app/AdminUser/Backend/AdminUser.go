package Backend

import (
	"github.com/gin-gonic/gin"
	"golang.org/x/crypto/bcrypt"
	"strconv"
	"ych/vgo/app/AdminUser/Model"
	"ych/vgo/app/Common/Backend"
	"ych/vgo/internal/global"
	"ych/vgo/internal/pkg/middleware/auth"
	"ych/vgo/pkg/helper"
	"ych/vgo/pkg/response"
)

// Login 登录
func Login(ctx *gin.Context) {
	var user Model.AdminUser
	rules := map[string]map[string]string{
		"UserName": {"required": "用户名不能为空"},
		"Password": {"required": "密码不能为空"},
	}
	if !helper.BindAndValidate(ctx, &user, rules) {
		return
	}
	// 查询用户数据
	var dbUser Model.AdminUser
	if err := global.DbCon.Where("username = ?", user.UserName).First(&dbUser).Error; err != nil {
		response.Fail(ctx, "用户名或密码错误", "用户名或密码错误001", nil)
		return
	}
	// 验证密码
	if err := bcrypt.CompareHashAndPassword([]byte(dbUser.Password), []byte(user.Password)); err != nil {
		response.Fail(ctx, "用户名或密码错误", "用户名或密码错误002", nil)
		return
	}
	// 获取角色
	roles, err := global.Rbac.GetRolesForUser(strconv.FormatUint(dbUser.ID, 10))
	if err != nil {
		response.Fail(ctx, "获取用户角色失败", err.Error(), nil)
		return
	}
	// 生成 token
	res, err := auth.GenAdminToken(ctx, dbUser.ID, roles, dbUser.Super)
	if err != nil {
		response.Fail(ctx, "生成 token 失败", err.Error(), nil)
		return
	}
	response.Success(ctx, "登录成功", res)
}

func RegisterAdminUserRoutes() {
	global.Engine.Group("/backend").POST("/user/login", Login)

	articleHandler := Backend.NewCRUDHandler(&Model.AdminUser{}, nil)

	global.BackendRouter.GET("/users", articleHandler.Index)
	global.BackendRouter.POST("/users", articleHandler.Create)
	global.BackendRouter.PUT("/users", articleHandler.Update)
	global.BackendRouter.GET("/users/:id", articleHandler.Show)
	global.BackendRouter.DELETE("/users", articleHandler.Delete)
}
