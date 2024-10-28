package Bapi

import (
	"github.com/gin-gonic/gin"
	"ych/vgo/pkg/response"
)

// Index 列表
func Index(ctx *gin.Context) {
	response.Success(ctx, "成功", gin.H{
		"func": "bapi--Index",
	})
}

// Create 新增
func Create(ctx *gin.Context) {
	response.Success(ctx, "成功", gin.H{
		"func": "bapi--Create",
	})
}

// Update 编辑
func Update(ctx *gin.Context) {
	response.Success(ctx, "成功", gin.H{
		"func": "bapi--Update",
	})
}

// Show 详情
func Show(ctx *gin.Context) {
	response.Success(ctx, "成功", gin.H{
		"func": "bapi--Show",
	})
}

// Delete 删除
func Delete(ctx *gin.Context) {
	response.Success(ctx, "成功", gin.H{
		"func": "bapi--Delete",
	})
}
