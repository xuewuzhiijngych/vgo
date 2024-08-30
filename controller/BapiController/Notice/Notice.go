package Notice

import (
	"github.com/gin-gonic/gin"
	"strconv"
	"vgo/core/db"
	"vgo/core/response"
	Model "vgo/model"
)

// Index 公告列表
func Index(ctx *gin.Context) {
	var res []Model.Notice
	var total int64
	pageNo, err := strconv.Atoi(ctx.DefaultQuery("pageNum", "1"))
	if err != nil {
		response.Fail(ctx, "页码参数无效", nil)
		return
	}
	Size, err := strconv.Atoi(ctx.DefaultQuery("pageSize", "10"))
	if err != nil {
		response.Fail(ctx, "每页大小参数无效", nil)
		return
	}
	if err := db.Con().Model(&Model.Notice{}).Count(&total).Error; err != nil {
		response.Fail(ctx, "数据库查询失败", err.Error())
		return
	}
	if err := db.Con().Order("id desc").Offset((pageNo - 1) * Size).Limit(Size).Find(&res).Error; err != nil {
		response.Fail(ctx, "数据库查询失败", err.Error())
		return
	}
	totalPage := int(total) / Size
	if int(total)%Size != 0 {
		totalPage++
	}
	response.Success(ctx, "成功", gin.H{
		"pageNum":  pageNo,
		"total":    total,
		"pageSize": Size,
		"list":     res,
	}, nil)

}

// Detail 公告详情
func Detail(ctx *gin.Context) {
	idStr := ctx.DefaultQuery("id", "")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		response.Fail(ctx, "ID参数无效", nil)
		return
	}
	var res Model.Notice
	db.Con().First(&res, id)
	response.Success(ctx, "成功", res, nil)
}

// Create 创建公告
func Create(ctx *gin.Context) {
	var product Model.Notice
	if err := ctx.ShouldBindJSON(&product); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	db.Con().Create(&product)
	response.Success(ctx, "成功", product, nil)
}

// Update 更新公告
func Update(ctx *gin.Context) {
	var notice Model.Notice
	if err := ctx.ShouldBindJSON(&notice); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	if err := db.Con().Model(&Model.Notice{}).Where("id = ?", notice.ID).Updates(notice).Error; err != nil {
		response.Fail(ctx, "更新失败", err.Error())
		return
	}
	response.Success(ctx, "成功", nil, nil)
}

// Delete 删除公告
func Delete(ctx *gin.Context) {
	idStr := ctx.Param("id")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		response.Fail(ctx, "ID参数无效", nil)
		return
	}
	if err := db.Con().Delete(&Model.Notice{}, id).Error; err != nil {
		response.Fail(ctx, "删除失败", err.Error())
		return
	}
	response.Success(ctx, "成功", nil, nil)
}

// Change 改变公告状态
func Change(ctx *gin.Context) {
	var notice Model.Notice
	if err := ctx.ShouldBindJSON(&notice); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	if err := db.Con().Model(&Model.Notice{}).Where("id = ?", notice.ID).Updates(notice).Error; err != nil {
		response.Fail(ctx, "更新失败", err.Error())
		return
	}
	response.Success(ctx, "成功", nil, nil)

}
