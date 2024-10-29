package Backend

import (
	"github.com/gin-gonic/gin"
	"strconv"
	"ych/vgo/app/Article/Model"
	"ych/vgo/internal/global"
	"ych/vgo/internal/trans"
	"ych/vgo/pkg/helper"
	"ych/vgo/pkg/response"
)

// Index 列表
func Index(ctx *gin.Context) {
	var res []Model.Article
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
	if err := global.DbCon.Model(&Model.Article{}).Count(&total).Error; err != nil {
		response.Fail(ctx, "数据库查询失败", err.Error())
		return
	}
	if err := global.DbCon.Order("id desc").Offset((pageNo - 1) * Size).Limit(Size).Find(&res).Error; err != nil {
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

// Create 新增
func Create(ctx *gin.Context) {
	var model Model.Article
	if err := helper.BindJSON(ctx, &model); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	// 验证规则
	rules := map[string]map[string]string{
		"Title": {
			"required": trans.Trans(ctx, "标题不能为空"),
		},
	}
	if res, err := helper.Validate(model, rules); !res {
		response.Fail(ctx, err, nil)
		return
	}
	global.DbCon.Create(&model)
	response.Success(ctx, "成功", model, nil)
}

// Update 编辑
func Update(ctx *gin.Context) {
	var model Model.Article
	if err := helper.BindJSON(ctx, &model); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	if err := global.DbCon.Model(&Model.Article{}).Where("id = ?", model.ID).Updates(model).Error; err != nil {
		response.Fail(ctx, "更新失败", err.Error())
		return
	}
	response.Success(ctx, "成功", model, nil)
}

// Show 详情
func Show(ctx *gin.Context) {
	var request struct {
		ID int64 `json:"id"`
	}
	if err := helper.BindJSON(ctx, &request); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	var model Model.Article
	if err := global.DbCon.First(&model, request.ID).Error; err != nil {
		response.Fail(ctx, "查询失败", err.Error(), nil)
		return
	}
	response.Success(ctx, "成功", model, nil)
}

// Delete 删除
func Delete(ctx *gin.Context) {
	var ids struct {
		ID []int64 `json:"id"`
	}
	if err := helper.BindJSON(ctx, &ids); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	if err := global.DbCon.Delete(&Model.Article{}, "id in (?)", ids.ID).Error; err != nil {
		response.Fail(ctx, "删除失败", err.Error())
		return
	}
	response.Success(ctx, "成功", nil, nil)
}
