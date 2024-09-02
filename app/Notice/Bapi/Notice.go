package Notice

import (
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"strconv"
	NoticeModel "vgo/app/Notice/Model"
	"vgo/core/db"
	"vgo/core/log"
	"vgo/core/response"
)

// Index 列表
func Index(ctx *gin.Context) {
	var res []NoticeModel.Notice
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
	if err := db.Con().Model(&NoticeModel.Notice{}).Count(&total).Error; err != nil {
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

// Create 创建
func Create(ctx *gin.Context) {
	var product NoticeModel.Notice
	if err := ctx.ShouldBindJSON(&product); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	db.Con().Create(&product)
	response.Success(ctx, "成功", product, nil)
}

// Update 更新
func Update(ctx *gin.Context) {
	var notice NoticeModel.Notice
	if err := ctx.ShouldBindJSON(&notice); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	if err := db.Con().Model(&NoticeModel.Notice{}).Where("id = ?", notice.ID).Updates(notice).Error; err != nil {
		response.Fail(ctx, "更新失败", err.Error())
		return
	}
	response.Success(ctx, "成功", nil, nil)
}

// Delete 删除
func Delete(ctx *gin.Context) {
	log.GetLogger().Info("Delete", zap.Any("ctx", ctx))

	ids := ctx.QueryArray("id")
	if err := db.Con().Model(&NoticeModel.Notice{}).Where("id in (?)", ids).Error; err != nil {
		response.Fail(ctx, "删除失败", err.Error())
		return
	}
	response.Success(ctx, "成功", nil, nil)
}

// Change 改变状态
func Change(ctx *gin.Context) {
	var notice NoticeModel.Notice
	if err := ctx.ShouldBindJSON(&notice); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	if err := db.Con().Model(&NoticeModel.Notice{}).Where("id = ?", notice.ID).Updates(notice).Error; err != nil {
		response.Fail(ctx, "更新失败", err.Error())
		return
	}
	response.Success(ctx, "成功", nil, nil)

}