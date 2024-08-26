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

	err := db.Con().AutoMigrate(&Model.Product{})
	if err != nil {
		return
	}
}
