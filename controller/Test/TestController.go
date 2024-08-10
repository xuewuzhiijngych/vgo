package Test

import (
	"github.com/gin-gonic/gin"
	"vgo/core/helper"
	"vgo/core/response"
	"vgo/model/Product"
)

func Index(ctx *gin.Context) {
	//res := time.Duration(global.App.Config.JwtConf.Timeout)
	//response.Success(ctx, "成功", map[string]interface{}{}, res)

	//query := db.GetCon().Model(&Product.Product{}).Find(&Product.Product{})
	//response.Success(ctx, "查询成功", query, nil)

	err, lists := helper.Pagination(ctx, "products", Product.Product{}, "id asc", "id,name,price,stock,created_at")
	if err != nil {
		response.Fail(ctx, "查询失败", nil, nil)
		return
	}
	response.Success(ctx, "查询成功", lists, nil)

}
