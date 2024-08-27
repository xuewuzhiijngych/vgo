package AdminUser

import (
	"errors"
	"github.com/gin-gonic/gin"
	"github.com/go-sql-driver/mysql"
	"golang.org/x/crypto/bcrypt"
	"strconv"
	"vgo/core/db"
	"vgo/core/middle/auth"
	"vgo/core/response"
	Model "vgo/model"
)

// Create 创建用户
func Create(ctx *gin.Context) {
	var user Model.AdminUser
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
	var user Model.AdminUser
	if err := ctx.ShouldBindJSON(&user); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	// 查询用户数据
	var dbUser Model.AdminUser
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
	res, err := auth.GenAdminToken(strconv.Itoa(int(dbUser.ID)), "admin")
	if err != nil {
		response.Fail(ctx, "登录失败", nil)
	}
	response.Success(ctx, "登录成功", res)
}
