package ProductOrder

import (
	"github.com/gin-gonic/gin"
	"vgo/core/response"
	"vgo/model/ProductOrder"
)

// Index 商品订单列表
func Index(ctx *gin.Context) {
	res := ProductOrder.Pagination(ctx)
	response.Success(ctx, "成功", res, nil)
}

// Detail 商品订单详情
func Detail(ctx *gin.Context) {
	res := ProductOrder.Detail(ctx)
	response.Success(ctx, "成功", res, nil)
}
