package Menu

import (
	"github.com/gin-gonic/gin"
	"strconv"
	"vgo/core/db"
	"vgo/core/response"
	Model "vgo/model"
)

// Index 无限极分类菜单结构
func Index(ctx *gin.Context) {
	var menus []Model.Menu
	db.Con().Order("sort desc").Find(&menus)
	menuTree := Model.BuildMenuTree(menus, 0)
	response.Success(ctx, "成功", menuTree, nil)
}

// Buttons 操作按钮
func Buttons(ctx *gin.Context) {
	var data = make(map[string][]string)
	var menus []Model.Menu

	if err := db.Con().Where("type = ?", 1).Find(&menus).Error; err != nil {
		response.Fail(ctx, "数据库查询失败", err)
		return
	}

	for _, menu := range menus {
		var buttonMenus []Model.Menu
		if err := db.Con().Where("parent_id = ? and type = ?", menu.ID, 2).Find(&buttonMenus).Error; err != nil {
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
}

// MenuSelect 下拉树结构
type MenuSelect struct {
	Value    uint64       `json:"value"`
	Label    string       `json:"label"`
	Children []MenuSelect `json:"children"`
}

// convertToMenuSelect 将Menu结构体转换为MenuSelect结构体
func convertToMenuSelect(menu Model.Menu) MenuSelect {
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
	var menus []Model.Menu
	if err := db.Con().Order("sort desc").Find(&menus).Error; err != nil {
		response.Fail(ctx, "数据库查询失败", err)
		return
	}
	menuTree := Model.BuildMenuTree(menus, 0)
	menuSelects := make([]MenuSelect, len(menuTree))
	for i, menu := range menuTree {
		menuSelects[i] = convertToMenuSelect(menu)
	}
	response.Success(ctx, "查询成功", menuSelects, nil)
}

// Create 创建
func Create(ctx *gin.Context) {
	var product Model.Menu
	if err := ctx.ShouldBindJSON(&product); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	db.Con().Create(&product)
	response.Success(ctx, "成功", product, nil)
}

// Update 更新
func Update(ctx *gin.Context) {
	var notice Model.Notice
	if err := ctx.ShouldBindJSON(&notice); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	if err := db.Con().Model(&Model.Notice{}).Where("id = ?", notice.ID).Updates(notice).Error; err != nil {
		response.Fail(ctx, "更新失败", err.Error())
		return
	}
	response.Success(ctx, "成功", nil, nil)
}

// Delete 删除
func Delete(ctx *gin.Context) {
	idStr := ctx.Param("id")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		response.Fail(ctx, "ID参数无效", nil)
		return
	}
	if err := db.Con().Model(&Model.Menu{}).Where("parent_id = ?", id).Error; err != nil {
		response.Fail(ctx, "删除失败", err.Error())
		return
	}
	if err := db.Con().Delete(&Model.Menu{}, id).Error; err != nil {
		response.Fail(ctx, "删除失败", err.Error())
		return
	}
	response.Success(ctx, "成功", nil, nil)
}
