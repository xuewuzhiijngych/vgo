package Backend

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"strconv"
	"ych/vgo/app/Notice/Model"
	"ych/vgo/internal/global"
	"ych/vgo/pkg/helper"
	"ych/vgo/pkg/response"
)

// Index 列表
func Index(ctx *gin.Context) {
	var res []Model.Notice
	var total int64
	pageNo, err := strconv.Atoi(ctx.DefaultQuery("pageNum", "1"))
	pageSize, err := strconv.Atoi(ctx.DefaultQuery("pageSize", "10"))
	if helper.HandleErr(ctx, err, "参数无效") {
		return
	}
	if err := global.DbCon.Model(&Model.Notice{}).Count(&total).Error; helper.HandleErr(ctx, err, "数据库查询失败") {
		return
	}
	if err := global.DbCon.Order("id desc").Offset((pageNo - 1) * pageSize).Limit(pageSize).Find(&res).Error; helper.HandleErr(ctx, err, "数据库查询失败") {
		return
	}
	totalPages := (int(total) + pageSize - 1) / pageSize
	response.Success(ctx, "成功", gin.H{
		"pageNum":  pageNo,
		"total":    totalPages,
		"pageSize": pageSize,
		"list":     res,
	}, nil)
}

// Create 新增
func Create(ctx *gin.Context) {
	var model Model.Notice
	if err := helper.BindJSON(ctx, &model); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	// 验证规则
	rules := map[string]map[string]string{
		"Title": {
			"required": "标题不能为空",
		},
	}
	if res, err := helper.Validate(model, rules); !res {
		response.Fail(ctx, err, nil)
		return
	}
	err := global.DbCon.Create(&model).Error
	if err != nil {
		response.Fail(ctx, "新增失败", err.Error())
		return
	}
	response.Success(ctx, "成功", model, nil)
}

// Update 编辑
func Update(ctx *gin.Context) {
	var model Model.Notice
	if err := helper.BindJSON(ctx, &model); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	if err := global.DbCon.Model(&Model.Notice{}).Where("id = ?", model.ID).Updates(model).Error; err != nil {
		response.Fail(ctx, "更新失败", err.Error())
		return
	}
	response.Success(ctx, "成功", model, nil)
}

// Show 详情
func Show(ctx *gin.Context) {
	idParam := ctx.Param("id")
	id, err := strconv.ParseInt(idParam, 10, 64)
	if err != nil {
		response.Fail(ctx, "无效的ID参数", nil)
		return
	}
	var model Model.Notice
	if err := global.DbCon.First(&model, id).Error; helper.HandleErr(ctx, err, "") {
		return
	}
	response.Success(ctx, "成功", model, nil)
}

// Delete 删除
func Delete(ctx *gin.Context) {
	idStrings := ctx.QueryArray("id[]")
	var ids []int64
	for _, idStr := range idStrings {
		var id int64
		if _, err := fmt.Sscan(idStr, &id); err == nil {
			ids = append(ids, id)
		}
	}
	if len(ids) == 0 {
		response.Fail(ctx, "参数错误", "未提供有效的ID", nil)
		return
	}
	fmt.Println(ids)
	var existingCount int64
	if err := global.DbCon.Model(&Model.Notice{}).Where("id in (?)", ids).Count(&existingCount).Error; helper.HandleErr(ctx, err, "查询失败") {
		return
	}
	if existingCount != int64(len(ids)) {
		response.Fail(ctx, "部分或全部记录不存在", nil)
		return
	}
	if err := global.DbCon.Delete(&Model.Notice{}, "id in (?)", ids).Error; err != nil {
		response.Fail(ctx, "删除失败", err.Error())
		return
	}
	response.Success(ctx, "成功", nil, nil)
}

// Change 改变状态
func Change(ctx *gin.Context) {
	var notice Model.Notice
	if err := helper.BindJSON(ctx, &notice); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	if err := global.DbCon.Model(&Model.Notice{}).Where("id = ?", notice.ID).Updates(notice).Error; err != nil {
		response.Fail(ctx, "更新失败", err.Error())
		return
	}
	response.Success(ctx, "成功", nil, nil)
}

func RegisterNoticeRoutes() {
	global.BackendRouter.GET("/notices", Index)
	global.BackendRouter.POST("/notices", Create)
	global.BackendRouter.PUT("/notices", Update)
	global.BackendRouter.GET("/notices/:id", Show)
	global.BackendRouter.DELETE("/notices", Delete)
	global.BackendRouter.POST("/notices/change", Change)
}
