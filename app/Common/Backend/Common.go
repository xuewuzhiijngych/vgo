package Backend

import (
	"github.com/gin-gonic/gin"
	"reflect"
	"strconv"
	"ych/vgo/internal/global"
	"ych/vgo/pkg/helper"
	"ych/vgo/pkg/response"
)

type CRUDHandler struct {
	Model    interface{}                  // 模型指针，用于创建实例
	Validate map[string]map[string]string // 验证规则函数，返回验证规则
}

func NewCRUDHandler(model interface{}, validate map[string]map[string]string) *CRUDHandler {
	return &CRUDHandler{
		Model:    model,
		Validate: validate,
	}
}

// Index 通用列表查询
func (h *CRUDHandler) Index(ctx *gin.Context) {
	pageNo, err := strconv.Atoi(ctx.DefaultQuery("pageNum", "1"))
	pageSize, err := strconv.Atoi(ctx.DefaultQuery("pageSize", "10"))
	if helper.HandleErr(ctx, err, "参数无效") {
		return
	}

	// 创建一个指向模型切片的指针
	modelSlicePtr := reflect.New(reflect.SliceOf(reflect.TypeOf(h.Model).Elem())).Interface()

	var total int64
	db := global.DbCon.Model(h.Model)

	if err := db.Count(&total).Error; helper.HandleErr(ctx, err, "数据库查询失败") {
		return
	}

	if err := db.Order("id desc").Offset((pageNo - 1) * pageSize).Limit(pageSize).Find(modelSlicePtr).Error; helper.HandleErr(ctx, err, "数据库查询失败") {
		return
	}

	modelSlice := reflect.ValueOf(modelSlicePtr).Elem().Interface()

	totalPages := (int(total) + pageSize - 1) / pageSize
	response.Success(ctx, "成功", gin.H{
		"pageNum":  pageNo,
		"total":    totalPages,
		"pageSize": pageSize,
		"list":     modelSlice,
	}, nil)
}

// Create 通用创建
func (h *CRUDHandler) Create(ctx *gin.Context) {
	model := reflect.New(reflect.TypeOf(h.Model).Elem()).Interface()
	if !helper.BindAndValidate(ctx, model, h.Validate) {
		return
	}
	if err := global.DbCon.Create(model).Error; helper.HandleErr(ctx, err, "创建失败") {
		return
	}
	response.Success(ctx, "成功", model, nil)
}

// Update 通用编辑
func (h *CRUDHandler) Update(ctx *gin.Context) {
	model := reflect.New(reflect.TypeOf(h.Model).Elem()).Interface()
	if err := helper.BindJSON(ctx, model); helper.HandleErr(ctx, err, "参数错误") {
		return
	}

	idField := reflect.ValueOf(model).Elem().FieldByName("ID")
	if !idField.IsValid() || idField.IsZero() {
		response.Fail(ctx, "记录 ID 无效", nil)
		return
	}

	existing := reflect.New(reflect.TypeOf(h.Model).Elem()).Interface()
	if err := global.DbCon.First(existing, idField.Interface()).Error; helper.HandleErr(ctx, err, "记录不存在") {
		return
	}

	if err := global.DbCon.Model(existing).Updates(model).Error; helper.HandleErr(ctx, err, "更新失败") {
		return
	}
	response.Success(ctx, "成功", model, nil)
}

// Show 通用详情
func (h *CRUDHandler) Show(ctx *gin.Context) {
	// 从 URL 参数中获取 ID
	idParam := ctx.Param("id")
	id, err := strconv.ParseInt(idParam, 10, 64)
	if err != nil {
		response.Fail(ctx, "无效的ID参数", nil)
		return
	}

	// 创建模型实例
	model := reflect.New(reflect.TypeOf(h.Model).Elem()).Interface()

	// 查询数据库
	if err := global.DbCon.First(model, id).Error; helper.HandleErr(ctx, err, "查询失败") {
		return
	}

	// 返回成功响应
	response.Success(ctx, "成功", model, nil)
}

// Delete 通用删除
func (h *CRUDHandler) Delete(ctx *gin.Context) {
	var ids struct {
		ID []int64 `json:"id"`
	}
	if !helper.BindAndValidate(ctx, &ids, nil) {
		return
	}

	var existingCount int64
	if err := global.DbCon.Model(h.Model).Where("id in (?)", ids.ID).Count(&existingCount).Error; helper.HandleErr(ctx, err, "查询失败") {
		return
	}
	if existingCount != int64(len(ids.ID)) {
		response.Fail(ctx, "部分或全部记录不存在", nil)
		return
	}

	if err := global.DbCon.Where("id in (?)", ids.ID).Delete(h.Model).Error; helper.HandleErr(ctx, err, "删除失败") {
		return
	}
	response.Success(ctx, "成功", nil, nil)
}
