package Test

import (
	"github.com/gin-gonic/gin"
	"vgo/core/db"
	Model "vgo/model"
)

func Index(ctx *gin.Context) {
	//res := time.Duration(global.App.Config.JwtConf.Timeout)
	//response.Success(ctx, "成功", map[string]interface{}{}, res)

	//query := db.GetCon().Model(&Product.Product{}).Find(&Product.Product{})
	//response.Success(ctx, "查询成功", query, nil)

	err := db.Con().AutoMigrate(&Model.Notice{})
	if err != nil {
		return
	}

	//// 查询整个菜单表
	//var menus []Model.Menu
	//db.Con().Find(&menus)
	//// 生成无限极分类的菜单结构
	//menuTree := Model.BuildMenuTree(menus, 0) // 0表示根节点
	//response.Success(ctx, "查询成功", menuTree, nil)

	// // 生成无限极分类的菜单结构
	//menuTree := Model.BuildMenuTree(menus, 0) // 0表示根节点
}
