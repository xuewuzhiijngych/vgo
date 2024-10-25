package Tpl

import (
	"github.com/gin-gonic/gin"
	"strconv"
	TplModel "vgo/internal/Tpl/Model"
	"vgo/internal/db"
	"vgo/internal/helper"
	"vgo/internal/response"
)

// Index 列表
func Index(ctx *gin.Context) {
	var res []TplModel.Tpl
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
	if err := db.Con().Model(&TplModel.Tpl{}).Count(&total).Error; err != nil {
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
	var tpl TplModel.Tpl
	if err := helper.VgoShouldBindJSON(ctx, &tpl); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	db.Con().Create(&tpl)
	response.Success(ctx, "成功", tpl, nil)
}

// Update 更新
func Update(ctx *gin.Context) {
	var tpl TplModel.Tpl
	if err := helper.VgoShouldBindJSON(ctx, &tpl); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	if err := db.Con().Model(&TplModel.Tpl{}).Where("id = ?", tpl.ID).Updates(tpl).Error; err != nil {
		response.Fail(ctx, "更新失败", err.Error())
		return
	}
	response.Success(ctx, "成功", nil, nil)
}

// Delete 删除
func Delete(ctx *gin.Context) {
	var ids struct {
		ID []int64 `json:"id"`
	}
	if err := helper.VgoShouldBindJSON(ctx, &ids); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	if err := db.Con().Delete(&TplModel.Tpl{}, "id in (?)", ids.ID).Error; err != nil {
		response.Fail(ctx, "删除失败", err.Error())
		return
	}
	response.Success(ctx, "成功", nil, nil)
}
