package Info

import (
	"github.com/gin-gonic/gin"
	"strconv"
	"vgo/core/response"
	"vgo/model/Info"
)

func Index(ctx *gin.Context) {
	var res []Info.Build
	page := ctx.DefaultQuery("page", "")
	pageSize := ctx.DefaultQuery("page_size", "")
	pageNo, _ := strconv.Atoi(page)
	Size, _ := strconv.Atoi(pageSize)

	Info.Query().Offset(pageNo - 1).Limit(Size).Find(&res)
	response.Success(ctx, "成功", map[string]interface{}{
		"page":     pageNo,
		"pageSize": pageSize,
		"lists":    res,
	}, nil)
}

func Detail(ctx *gin.Context) {
	var res []Info.Build
	id := ctx.PostForm("id")
	Info.Query().Where("id = ?", id).Find(&res)
	response.Success(ctx, "成功", res, nil)
}
