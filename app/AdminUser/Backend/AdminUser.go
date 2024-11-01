package Backend

import (
	"errors"
	"github.com/gin-gonic/gin"
	"github.com/go-sql-driver/mysql"
	"golang.org/x/crypto/bcrypt"
	"gorm.io/gorm"
	"strconv"
	"ych/vgo/app/AdminUser/Model"
	"ych/vgo/app/Common/Backend"
	"ych/vgo/internal/global"
	"ych/vgo/internal/pkg/middleware/auth"
	"ych/vgo/pkg/helper"
	"ych/vgo/pkg/response"
)

// Create 创建用户
func Create(ctx *gin.Context) {
	var user Model.AdminUser
	if err := helper.BindJSON(ctx, &user); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	// 查询已存在的用户
	var existingUser Model.AdminUser
	if err := global.DbCon.Where("username = ?", user.UserName).First(&existingUser).Error; err != nil {
		if !errors.Is(err, gorm.ErrRecordNotFound) {
			response.Fail(ctx, "查询用户失败", err.Error(), nil)
			return
		}
	} else {
		response.Fail(ctx, "用户名已存在", nil, nil)
		return
	}
	// 对密码进行哈希处理
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(user.Password), bcrypt.DefaultCost)
	if err != nil {
		response.Fail(ctx, "密码哈希失败", err.Error(), nil)
		return
	}
	user.Password = string(hashedPassword)
	// 插入用户数据
	if err := global.DbCon.Create(&user).Error; err != nil {
		// 检查是否是唯一键冲突错误
		var mysqlErr *mysql.MySQLError
		if errors.As(err, &mysqlErr) && mysqlErr.Number == 1062 {
			response.Fail(ctx, "用户名已存在", err.Error(), nil)
		}
		return
	}
	response.Success(ctx, "成功", user, nil)
}

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

// LogOut 退出登录
func LogOut(ctx *gin.Context) {
	userID := ctx.GetUint64("userID")
	err := auth.DelAdminToken(ctx, userID)
	if err != nil {
		return
	}
	response.Success(ctx, "退出成功", nil)
}

// SetRole 设置角色
func SetRole(ctx *gin.Context) {
	var codes struct {
		ID    uint64   `json:"id"`
		Roles []string `json:"roles"`
	}
	if err := helper.BindJSON(ctx, &codes); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	userID := codes.ID
	enforcer := global.Rbac
	_, err := enforcer.DeleteRolesForUser(strconv.FormatUint(userID, 10))
	if err != nil {
		response.Fail(ctx, err.Error(), nil)
		return
	}
	for _, role := range codes.Roles {
		_, err2 := enforcer.AddRoleForUser(strconv.FormatUint(userID, 10), role)
		if err2 != nil {
			response.Fail(ctx, err2.Error(), nil)
			return
		}
	}
	response.Success(ctx, "设置成功", nil, nil)
}

// GetRole 获取角色
func GetRole(ctx *gin.Context) {
	var codes struct {
		ID uint64 `json:"id"`
	}
	if err := helper.BindJSON(ctx, &codes); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	userID := codes.ID
	enforcer := global.Rbac
	roles, err := enforcer.GetRolesForUser(strconv.FormatUint(userID, 10))
	if err != nil {
		response.Fail(ctx, "获取错误", err.Error(), nil)
		return
	}
	response.Success(ctx, "获取成功", roles, nil)
}

func RegisterAdminUserRoutes() {
	global.Engine.Group("/backend").POST("/user/login", Login)

	articleHandler := Backend.NewCRUDHandler(&Model.AdminUser{}, nil)

	global.BackendRouter.GET("/users", articleHandler.Index)
	global.BackendRouter.POST("/users", Create)
	global.BackendRouter.PUT("/users", articleHandler.Update)
	global.BackendRouter.GET("/users/:id", articleHandler.Show)
	global.BackendRouter.DELETE("/users", articleHandler.Delete)
	global.BackendRouter.POST("/users/set/role", SetRole)
	global.BackendRouter.POST("/users/get/role", GetRole)
	global.BackendRouter.POST("/users/logout", LogOut)
}
