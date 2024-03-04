package Info

import (
	"github.com/gin-gonic/gin"
	"vgo/core/response"
	"vgo/model/Info"
)

// Index 列表
func Index(ctx *gin.Context) {
	res := Info.Pagination(ctx)
	response.Success(ctx, "成功", res, nil)
}

// Detail 详情
func Detail(ctx *gin.Context) {
	res := Info.Detail(ctx)
	response.Success(ctx, "成功", res, nil)
}
