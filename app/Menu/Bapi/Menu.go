package Menu

import (
	"github.com/gin-gonic/gin"
	"strconv"
	MenuModel "vgo/app/Menu/Model"
	Role "vgo/app/Role/Model"
	"vgo/core/db"
	"vgo/core/helper"
	"vgo/core/middle/casbin"
	"vgo/core/response"
)

// Index 无限极分类菜单结构
func Index(ctx *gin.Context) {
	var menus []MenuModel.Menu
	var err error
	if ctx.GetInt("super") == 1 { // 超级管理员
		err = db.Con().Order("sort desc").Find(&menus).Error
	} else {
		menuIDs := Role.GetMenuIdsByRoleId(ctx.GetUint64("userID"))
		err = db.Con().Order("sort desc").Find(&menus, "id in (?)", menuIDs).Error
	}
	if err != nil {
		response.Fail(ctx, "数据库查询失败", err)
		return
	}
	menuTree := MenuModel.BuildMenuTree(menus, 0)
	response.Success(ctx, "成功", menuTree, nil)
}

// Buttons 操作按钮
func Buttons(ctx *gin.Context) {
	var data = make(map[string][]string)
	var menus []MenuModel.Menu
	var err error

	if ctx.GetInt("super") == 1 { // 超级管理员
		if err = db.Con().Where("type = ?", 1).Find(&menus).Error; err != nil {
			response.Fail(ctx, "数据库查询失败", err)
			return
		}
		for _, menu := range menus {
			var buttonMenus []MenuModel.Menu
			if err = db.Con().Where("parent_id = ? and type = ?", menu.ID, 2).Find(&buttonMenus).Error; err != nil {
				response.Fail(ctx, "数据库查询失败", err)
				return
			}
			if len(buttonMenus) > 0 {
				bbt := make([]string, len(buttonMenus))
				for i, buttonMenu := range buttonMenus {
					bbt[i] = buttonMenu.Name
				}
				data[menu.Name] = bbt
			}
		}
		response.Success(ctx, "成功", data, nil)
		return
	}
	menuIDs := Role.GetMenuIdsByRoleId(ctx.GetUint64("userID"))
	if err = db.Con().Where("type = ? and id in (?)", 1, menuIDs).Find(&menus).Error; err != nil {
		response.Fail(ctx, "数据库查询失败", err)
		return
	}
	// 获取角色
	enforcer := casbin.SetupCasbin()
	roles, err := enforcer.GetRolesForUser(strconv.FormatUint(ctx.GetUint64("userID"), 10))
	if err != nil {
		response.Fail(ctx, "角色获取失败", err)
		return
	}
	for _, menu := range menus {
		var buttonMenus []MenuModel.Menu
		if err = db.Con().Where("parent_id = ? and type = ?", menu.ID, 2).Find(&buttonMenus).Error; err != nil {
			response.Fail(ctx, "数据库查询失败", err)
			return
		}
		if len(buttonMenus) == 0 {
			continue
		}
		bbt := make([]string, 0, len(buttonMenus))
		for _, buttonMenu := range buttonMenus {
			if buttonMenu.Name == "" {
				continue
			}
			// 判断按钮是否有权限
			hasPermission := false
			for _, role := range roles {
				if policy, err := enforcer.HasPolicy(role, buttonMenu.Api); err == nil && policy {
					hasPermission = true
					break
				}
			}
			if hasPermission {
				bbt = append(bbt, buttonMenu.Name)
			}
		}
		if len(bbt) > 0 {
			data[menu.Name] = bbt
		}
	}
	response.Success(ctx, "成功", data, nil)
}

// MenuSelect 下拉树结构
type MenuSelect struct {
	Value    uint64       `json:"value"`
	Label    string       `json:"label"`
	Children []MenuSelect `json:"children"`
}

// convertToMenuSelect 将Menu结构体转换为MenuSelect结构体
func convertToMenuSelect(menu MenuModel.Menu) MenuSelect {
	menuSelect := MenuSelect{
		Value:    menu.ID,    // 假设Menu结构体中有ID字段
		Label:    menu.Title, // 假设Menu结构体中有Name字段
		Children: []MenuSelect{},
	}
	for _, child := range menu.Children {
		menuSelect.Children = append(menuSelect.Children, convertToMenuSelect(child))
	}
	return menuSelect
}

// GetSelectTree 获取下拉树结构
func GetSelectTree(ctx *gin.Context) {
	var menus []MenuModel.Menu
	if err := db.Con().Order("sort desc").Find(&menus).Error; err != nil {
		response.Fail(ctx, "数据库查询失败", err)
		return
	}
	menuTree := MenuModel.BuildMenuTree(menus, 0)
	menuSelects := make([]MenuSelect, len(menuTree))
	for i, menu := range menuTree {
		menuSelects[i] = convertToMenuSelect(menu)
	}
	response.Success(ctx, "查询成功", menuSelects, nil)
}

// Create 创建
func Create(ctx *gin.Context) {
	var product MenuModel.Menu
	if err := helper.VgoShouldBindJSON(ctx, &product); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	db.Con().Create(&product)
	response.Success(ctx, "成功", product, nil)
}

// Update 更新
func Update(ctx *gin.Context) {
	var notice MenuModel.Menu
	if err := helper.VgoShouldBindJSON(ctx, &notice); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	if err := db.Con().Model(&MenuModel.Menu{}).Where("id = ?", notice.ID).Updates(notice).Error; err != nil {
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
	if err := helper.VgoShouldBindJSON(ctx, &ids); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	if err := db.Con().Delete(&MenuModel.Menu{}, "parent_id in (?)", ids.ID).Error; err != nil {
		response.Fail(ctx, "删除失败", err.Error())
		return
	}
	if err := db.Con().Delete(&MenuModel.Menu{}, "id in (?)", ids.ID).Error; err != nil {
		response.Fail(ctx, "删除失败", err.Error())
		return
	}
	response.Success(ctx, "成功", nil, nil)
}
