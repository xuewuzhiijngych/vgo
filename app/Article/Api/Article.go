package Api

import (
	"github.com/gin-gonic/gin"
	"ych/vgo/pkg/response"
)

// Index 列表
func Index(ctx *gin.Context) {
	response.Success(ctx, "成功", gin.H{
		"func": "api--Index",
	})
}

// Create 新增
func Create(ctx *gin.Context) {
	response.Success(ctx, "成功", gin.H{
		"func": "api--Create",
	})
}

// Update 编辑
func Update(ctx *gin.Context) {
	response.Success(ctx, "成功", gin.H{
		"func": "api--Update",
	})
}

// Show 详情
func Show(ctx *gin.Context) {
	response.Success(ctx, "成功", gin.H{
		"func": "api--Show",
	})
}

// Delete 删除
func Delete(ctx *gin.Context) {
	response.Success(ctx, "成功", gin.H{
		"func": "api--Delete",
	})
}
