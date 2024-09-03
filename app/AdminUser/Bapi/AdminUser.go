package AdminUser

import (
	"errors"
	"github.com/gin-gonic/gin"
	"github.com/go-sql-driver/mysql"
	"golang.org/x/crypto/bcrypt"
	"strconv"
	AdminUserModel "vgo/app/AdminUser/Model"
	MenuModel "vgo/app/Menu/Model"
	"vgo/core/db"
	"vgo/core/middle/auth"
	"vgo/core/response"
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
	if err := db.Con().Order("id desc").Offset((pageNo - 1) * Size).Limit(Size).Find(&res).Error; err != nil {
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

// Create 创建用户
func Create(ctx *gin.Context) {
	var user AdminUserModel.AdminUser
	if err := ctx.ShouldBindJSON(&user); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
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
	if err := ctx.ShouldBindJSON(&user); err != nil {
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
	// 生成token
	res, err := auth.GenAdminToken(ctx, strconv.Itoa(int(dbUser.ID)), []string{"admin"}, dbUser.Super)
	if err != nil {
		response.Fail(ctx, err.Error(), nil)
		return
	}
	response.Success(ctx, "登录成功", res)
}

// LogOut 退出登录
func LogOut(ctx *gin.Context) {
	userID := ctx.GetString("userID")
	err := auth.DelAdminToken(ctx, userID)
	if err != nil {
		return
	}
	response.Success(ctx, "退出成功", nil)
}

// Update 更新
func Update(ctx *gin.Context) {
	var notice AdminUserModel.AdminUser
	if err := ctx.ShouldBindJSON(&notice); err != nil {
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
	type Ids struct {
		ID []int64 `json:"id"`
	}
	var ids Ids
	if err := ctx.ShouldBindJSON(&ids); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	// 删除token
	for _, values := range ids.ID {
		err := auth.DelAdminToken(ctx, strconv.Itoa(int(values)))
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
	userID := ctx.GetString("userID")
	role := ctx.GetString("Role")
	response.Success(ctx, "成功", map[string]interface{}{
		"userID":  userID,
		"role":    role,
		"message": "pong",
	}, nil)
}

// GetInfo 获取管理员权限和菜单
func GetInfo(ctx *gin.Context) {
	userID := ctx.GetString("userID")
	// 无限极分类菜单结构
	var menus []MenuModel.Menu
	db.Con().Order("sort desc").Find(&menus)
	menuTree := MenuModel.BuildMenuTree(menus, 0)

	// 管理员信息
	var adminUser AdminUserModel.AdminUser
	db.Con().First(&adminUser, "id = ?", userID)

	response.Success(ctx, "成功", gin.H{
		"codes":   []string{"*"},
		"roles":   []string{"superAdmin"},
		"routers": menuTree,
		"user":    adminUser,
	}, nil)
}
