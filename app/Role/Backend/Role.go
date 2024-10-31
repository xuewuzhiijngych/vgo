package Backend

import (
	"errors"
	"github.com/gin-gonic/gin"
	"github.com/go-sql-driver/mysql"
	"strconv"
	MenuModel "ych/vgo/app/Menu/Model"
	"ych/vgo/app/Role/Model"
	"ych/vgo/internal/global"
	"ych/vgo/pkg/helper"
	"ych/vgo/pkg/response"
)

// Index 列表
func Index(ctx *gin.Context) {
	var res []Model.Role
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
	if err := global.DbCon.Model(&Model.Role{}).Count(&total).Error; err != nil {
		response.Fail(ctx, "数据库查询失败", err.Error())
		return
	}
	if err := global.DbCon.Order("id desc").Offset((pageNo - 1) * Size).Limit(Size).Find(&res).Error; err != nil {
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

// GetAll 获取全部
func GetAll(ctx *gin.Context) {
	var res []Model.Role
	if err := global.DbCon.Order("id desc").Find(&res).Error; err != nil {
		response.Fail(ctx, "数据库查询失败", err.Error())
		return
	}
	response.Success(ctx, "成功", res, nil)
}

// Create 创建
func Create(ctx *gin.Context) {
	var role Model.Role
	if err := helper.BindJSON(ctx, &role); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	// 插入数据
	if err := global.DbCon.Create(&role).Error; err != nil {
		// 检查是否是唯一键冲突错误
		var mysqlErr *mysql.MySQLError
		if errors.As(err, &mysqlErr) && mysqlErr.Number == 1062 {
			response.Fail(ctx, "角色标识已存在", err.Error(), nil)
		}
		return
	}
	response.Success(ctx, "成功", role, nil)
}

// SetMenu 设置菜单
func SetMenu(ctx *gin.Context) {
	var codes struct {
		ID    uint64   `json:"id"`
		Menus []uint64 `json:"menus"`
	}
	if err := helper.BindJSON(ctx, &codes); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	roleID := codes.ID
	// 清理原有菜单
	if err := global.DbCon.Delete(&Model.RoleMenu{}, "role_id = ?", roleID).Error; err != nil {
		response.Fail(ctx, "菜单清理失败", err.Error())
		return
	}
	// 角色信息
	var role Model.Role
	global.DbCon.First(&role, roleID)
	// 清理原有策略
	enforcer := global.Rbac
	_, err := enforcer.RemoveFilteredPolicy(0, role.Code)
	if err != nil {
		response.Fail(ctx, "策略清理失败", err.Error())
		return
	}
	// 写入菜单
	var dbMenus []MenuModel.Menu
	global.DbCon.Where("id IN ?", codes.Menus).Find(&dbMenus)
	menuMap := make(map[int]MenuModel.Menu)
	for _, dbMenu := range dbMenus {
		menuMap[int(dbMenu.ID)] = dbMenu
	}
	// 写入角色菜单关联和策略
	for _, menu := range codes.Menus {
		var item Model.RoleMenu
		item.RoleId = roleID
		item.MenuId = menu
		dbMenu, exists := menuMap[int(menu)]
		if exists {
			// 写入策略
			if dbMenu.Api != "" {
				_, err2 := enforcer.AddPolicy(role.Code, dbMenu.Api)
				if err2 != nil {
					response.Fail(ctx, "策略写入失败", err2.Error())
					return
				}
			}
		}
		if err := global.DbCon.Create(&item).Error; err != nil {
			response.Fail(ctx, err.Error(), err.Error())
			return
		}
	}
	response.Success(ctx, "设置成功", nil, nil)
}

// GetMenu 获取菜单
func GetMenu(ctx *gin.Context) {
	var codes struct {
		ID uint64 `json:"id"`
	}
	if err := helper.BindJSON(ctx, &codes); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	var res []Model.RoleMenu
	if err := global.DbCon.Where("role_id = ?", codes.ID).Find(&res).Error; err != nil {
		response.Fail(ctx, "数据库查询失败", err.Error())
		return
	}
	response.Success(ctx, "成功", res, nil)
}

// Update 更新
func Update(ctx *gin.Context) {
	var notice Model.Role
	if err := helper.BindJSON(ctx, &notice); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	if err := global.DbCon.Model(&Model.Role{}).Where("id = ?", notice.ID).Updates(notice).Error; err != nil {
		response.Fail(ctx, "更新失败", err.Error())
		return
	}
	response.Success(ctx, "成功", nil, nil)
}

// Delete 删除
func Delete(ctx *gin.Context) {
	var ids struct {
		ID []int64 `json:"id"`
	}
	if err := helper.BindJSON(ctx, &ids); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	if err := global.DbCon.Delete(&Model.Role{}, "id in (?)", ids.ID).Error; err != nil {
		response.Fail(ctx, "删除失败", err.Error())
		return
	}
	response.Success(ctx, "成功", nil, nil)
}

// Change 改变状态
func Change(ctx *gin.Context) {
	var notice Model.Role
	if err := helper.BindJSON(ctx, &notice); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	if err := global.DbCon.Model(&Model.Role{}).Where("id = ?", notice.ID).Updates(notice).Error; err != nil {
		response.Fail(ctx, "更新失败", err.Error())
		return
	}
	response.Success(ctx, "成功", nil, nil)

}
