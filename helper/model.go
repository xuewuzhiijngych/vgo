package helper

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
	"reflect"
	"strconv"
	"strings"
	"vgo/core/db"
)

// BaseBuild 数据模型
type BaseBuild interface {
}

// PaginationResponse 分页响应
type PaginationResponse struct {
	Page     int         `json:"page"`
	PageSize int         `json:"page_size"`
	Total    int64       `json:"total"`
	List     interface{} `json:"list"`
}

// GETQuery 获取查询对象
func GETQuery(TableName string) (tx *gorm.DB) {
	return db.GetCon().Table(TableName)
}

// Pagination 分页查询
func Pagination(ctx *gin.Context, TableName string, Build BaseBuild) (resp PaginationResponse) {
	Query := db.GetCon().Table(TableName)
	var total int64
	list := getType(Build)
	pageNo, _ := strconv.Atoi(ctx.DefaultQuery("page", "1"))
	pageSizeNo, _ := strconv.Atoi(ctx.DefaultQuery("page_size", "10"))
	// 总数
	Query.Count(&total)
	// 分页查询
	Query.Order("id desc").Offset((pageNo - 1) * pageSizeNo).Limit(pageSizeNo).Find(&list)
	// 响应
	resp = PaginationResponse{
		Page:     pageNo,
		PageSize: pageSizeNo,
		Total:    total,
		List:     list,
	}
	return resp
}

// First 详情
func First(ctx *gin.Context, TableName string, Build BaseBuild, options ...string) interface{} {
	query := db.GetCon().Table(TableName)
	res := getType(Build)
	queryField := "id"
	selectFields := "*"
	if len(options) >= 1 {
		queryField = options[0]
	}
	if len(options) >= 2 {
		selectFields = strings.Join(strings.Split(options[1], ","), ", ")
	}
	id := ctx.DefaultQuery(queryField, "0")
	if selectFields != "*" {
		query = query.Select(selectFields)
	}
	query.Where(fmt.Sprintf("%s = ?", queryField), id).First(&res)
	return res
}

// getType 获取类型
func getType(Build BaseBuild) interface{} {
	var res interface{}
	// 获取Build的实际类型
	buildType := reflect.TypeOf(Build)
	// 检查Build是否实现了某个接口或是个具体的结构体
	switch reflect.TypeOf(Build).Kind() {
	case reflect.Slice:
		// 如果Build已经是切片，可以直接转换
		res = reflect.New(reflect.SliceOf(buildType.Elem())).Interface()
	case reflect.Struct:
		// 如果Build是个结构体，创建一个该类型的切片
		res = reflect.MakeSlice(reflect.SliceOf(buildType), 0, 0).Interface()
	default:
		panic("未知类型")
	}
	return res
}
