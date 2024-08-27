package Product

import (
	"github.com/gin-gonic/gin"
	"strconv"
	"vgo/core/db"
	"vgo/core/response"
	Model "vgo/model"
)

// Index 产品列表
func Index(ctx *gin.Context) {
	var res []Model.Product
	pageNo, _ := strconv.Atoi(ctx.DefaultQuery("page", ""))
	Size, _ := strconv.Atoi(ctx.DefaultQuery("pageSize", ""))
	db.Con().Offset(pageNo - 1).Limit(Size).Find(&res)
	response.Success(ctx, "成功", map[string]interface{}{
		"page":     pageNo,
		"pageSize": Size,
		"lists":    res,
	}, nil)
}

// Detail 产品详情
func Detail(ctx *gin.Context) {
	idStr := ctx.DefaultQuery("id", "")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		response.Fail(ctx, "ID参数无效", nil)
		return
	}
	var res Model.Product
	db.Con().First(&res, id)
	response.Success(ctx, "成功", res, nil)
}

// Create 创建产品
func Create(ctx *gin.Context) {
	var product Model.Product
	if err := ctx.ShouldBindJSON(&product); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	db.Con().Create(&product)
	response.Success(ctx, "成功", product, nil)
}

// Update 更新产品
func Update(ctx *gin.Context) {
	idStr := ctx.Param("id")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		response.Fail(ctx, "ID参数无效", nil)
		return
	}
	var product Model.Product
	if err := ctx.ShouldBindJSON(&product); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	db.Con().Model(&Model.Product{}).Where("id =?", id).Updates(product)
	response.Success(ctx, "成功", nil, nil)
}

// Delete 删除产品
func Delete(ctx *gin.Context) {
	idStr := ctx.Param("id")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		response.Fail(ctx, "ID参数无效", nil)
	}
	db.Con().First(&Model.Product{}, id)
	db.Con().Delete(&Model.Product{}, id)
	response.Success(ctx, "成功", nil, nil)
}
