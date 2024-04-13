package Info

import (
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
	"strconv"
	"vgo/core/db"
)

var TableName = "infos"

type Build struct {
	ID          uint   `gorm:"primary_key"  json:"id"`
	Name        string `gorm:"column:name" json:"name"`
	Age         int    `gorm:"column:age" json:"age"`
	HiddenField string `gorm:"column:hidden_field" json:"-"`
	CreatedAt   int    `gorm:"column:created_at" json:"created_at"`
}

// PaginationResponse 分页响应
type PaginationResponse struct {
	Page     int     `json:"page"`
	PageSize int     `json:"page_size"`
	Total    int64   `json:"total"`
	List     []Build `json:"list"`
}

// Query 查询
func Query() (tx *gorm.DB) {
	return db.GetCon().Table(TableName)
}

// Pagination 分页查询
func Pagination(ctx *gin.Context) (resp PaginationResponse) {
	var list []Build
	var total int64
	pageNo, _ := strconv.Atoi(ctx.DefaultQuery("page", "1"))
	pageSizeNo, _ := strconv.Atoi(ctx.DefaultQuery("page_size", "10"))
	// 总数
	Query().Count(&total)
	// 分页查询
	Query().Order("id desc").Offset((pageNo - 1) * pageSizeNo).Limit(pageSizeNo).Find(&list)
	// 响应
	resp = PaginationResponse{
		Page:     pageNo,
		PageSize: pageSizeNo,
		Total:    total,
		List:     list,
	}
	return resp
}

// Detail 详情
func Detail(ctx *gin.Context) Build {
	var res Build
	id := ctx.DefaultQuery("id", "0")
	Query().Where("id = ?", id).Find(&res)
	return res
}
