package ProductOrder

import (
	"github.com/gin-gonic/gin"
	"vgo/core/response"
	"vgo/model/ProductOrder"
)

func Index(ctx *gin.Context) {
	res := ProductOrder.Pagination(ctx)
	response.Success(ctx, "成功", map[string]interface{}{
		"page":     res.Page,
		"pageSize": res.PageSize,
		"total":    res.Total,
		"lists":    res.List,
	}, nil)
}
