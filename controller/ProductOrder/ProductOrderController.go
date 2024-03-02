package ProductOrder

import (
	"github.com/gin-gonic/gin"
	"strconv"
	"vgo/core/response"
	"vgo/model/ProductOrder"
)

func Index(ctx *gin.Context) {
	var res []ProductOrder.Build
	var total int64 // 新增变量用于存储总记录数

	page := ctx.DefaultQuery("page", "")
	pageSize := ctx.DefaultQuery("page_size", "")
	pageNo, _ := strconv.Atoi(page)
	Size, _ := strconv.Atoi(pageSize)

	db := ProductOrder.Query()
	countResult := db.Count(&total)
	if countResult.Error != nil {
		response.Fail(ctx, "获取总记录数失败", map[string]interface{}{}, nil)
		return
	}

	db.Offset((pageNo - 1) * Size).Limit(Size).Find(&res)

	var a map[string]string
	a = make(map[string]string, 10)
	a["额外数据"] = "额外数据...."

	response.Success(ctx, "成功", map[string]interface{}{
		"total":    total, // 添加总记录数
		"page":     pageNo,
		"pageSize": pageSize,
		"lists":    res,
	}, a)
}
