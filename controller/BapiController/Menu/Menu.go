package Menu

import (
	"github.com/gin-gonic/gin"
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
