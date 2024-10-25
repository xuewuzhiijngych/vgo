package AdminUser

import (
	"errors"
	"github.com/gin-gonic/gin"
	"github.com/go-sql-driver/mysql"
	"golang.org/x/crypto/bcrypt"
	"gorm.io/gorm"
	"strconv"
	AdminUserModel "vgo/api/AdminUser/Model"
	"vgo/internal/db"
	"vgo/internal/helper"
	"vgo/internal/middle/auth"
	"vgo/internal/middle/casbin"
	"vgo/internal/response"
)

// Index 列表
func Index(ctx *gin.Context) {
	var res []AdminUserModel.AdminUser
	var total int64
	pageNo, err := strconv.Atoi(ctx.DefaultQuery("pageNum", "1"))
	if err != nil {
		response.Fail(ctx, "页码参数无效", nil)
		return
	}
	Size, err := strconv.Atoi(ctx.DefaultQuery("pageSize", "10"))
	if err != nil {
		response.Fail(ctx, "每页大小参数无效", nil)
		return
	}
	if err := db.Con().Model(&AdminUserModel.AdminUser{}).Count(&total).Error; err != nil {
		response.Fail(ctx, "数据库查询失败", err.Error())
		return
	}
	if err := db.Con().Order("id desc").Offset((pageNo-1)*Size).Limit(Size).Where("super = ?", 2).Find(&res).Error; err != nil {
		response.Fail(ctx, "数据库查询失败", err.Error())
		return
	}
	totalPage := int(total) / Size
	if int(total)%Size != 0 {
		totalPage++
	}
	response.Success(ctx, "成功", gin.H{
		"pageNum":  pageNo,
		"total":    total,
		"pageSize": Size,
		"list":     res,
	}, nil)
}

// SetRole 设置角色
func SetRole(ctx *gin.Context) {
	var codes struct {
		ID    uint64   `json:"id"`
		Roles []string `json:"roles"`
	}
	if err := helper.VgoShouldBindJSON(ctx, &codes); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	userID := codes.ID
	enforcer := casbin.SetupCasbin()
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
	if err := helper.VgoShouldBindJSON(ctx, &codes); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	userID := codes.ID
	enforcer := casbin.SetupCasbin()
	roles, err := enforcer.GetRolesForUser(strconv.FormatUint(userID, 10))
	if err != nil {
		response.Fail(ctx, "获取错误", err.Error(), nil)
		return
	}
	response.Success(ctx, "获取成功", roles, nil)
}

// Create 创建用户
func Create(ctx *gin.Context) {
	var user AdminUserModel.AdminUser
	if err := helper.VgoShouldBindJSON(ctx, &user); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	// 查询已存在的用户
	var existingUser AdminUserModel.AdminUser
	if err := db.Con().Where("username = ?", user.UserName).First(&existingUser).Error; err != nil {
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
	if err := db.Con().Create(&user).Error; err != nil {
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
	var user AdminUserModel.AdminUser
	if err := helper.VgoShouldBindJSON(ctx, &user); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	// 查询用户数据
	var dbUser AdminUserModel.AdminUser
	if err := db.Con().Where("username = ?", user.UserName).First(&dbUser).Error; err != nil {
		response.Fail(ctx, "用户名或密码错误001", err.Error(), nil)
		return
	}
	// 验证密码
	if err := bcrypt.CompareHashAndPassword([]byte(dbUser.Password), []byte(user.Password)); err != nil {
		response.Fail(ctx, "用户名或密码错误002", err.Error(), nil)
		return
	}
	// 获取角色
	enforcer := casbin.SetupCasbin()
	roles, err := enforcer.GetRolesForUser(strconv.FormatUint(dbUser.ID, 10))
	if err != nil {
		response.Fail(ctx, "获取错误", err.Error(), nil)
		return
	}
	// 生成token
	res, err := auth.GenAdminToken(ctx, dbUser.ID, roles, dbUser.Super)
	if err != nil {
		response.Fail(ctx, err.Error(), nil)
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

// Update 更新
func Update(ctx *gin.Context) {
	var notice AdminUserModel.AdminUser
	if err := helper.VgoShouldBindJSON(ctx, &notice); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	if err := db.Con().Model(&AdminUserModel.AdminUser{}).Where("id = ?", notice.ID).Updates(notice).Error; err != nil {
		response.Fail(ctx, "更新失败", err.Error())
		return
	}
	response.Success(ctx, "成功", nil, nil)
}

// Delete 删除
func Delete(ctx *gin.Context) {
	var ids struct {
		ID []uint64 `json:"id"`
	}
	if err := helper.VgoShouldBindJSON(ctx, &ids); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	// 删除token
	for _, values := range ids.ID {
		err := auth.DelAdminToken(ctx, values)
		if err != nil {
			continue
		}
	}
	if err := db.Con().Delete(&AdminUserModel.AdminUser{}, "id in (?)", ids.ID).Error; err != nil {
		response.Fail(ctx, "删除失败", err.Error())
		return
	}
	response.Success(ctx, "成功", nil, nil)
}

// UserInfo 用户信息
func UserInfo(ctx *gin.Context) {
	userID := ctx.GetUint64("userID")
	role := ctx.GetString("Role")
	response.Success(ctx, "成功", map[string]interface{}{
		"userID":  userID,
		"role":    role,
		"message": "pong",
	}, nil)
}
