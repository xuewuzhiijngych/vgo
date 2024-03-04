package ProductOrder

import (
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
	"strconv"
	"vgo/core/db"
)

// TableName 表名
var TableName = "product_orders"

// Build 数据模型
type Build struct {
	ID               uint    `gorm:"primary_key"  json:"id"`
	OrderType        string  `gorm:"column:order_type" json:"order_type"`
	Status           string  `gorm:"column:status" json:"status"`
	OrderSn          string  `gorm:"column:order_sn" json:"order_sn"`
	Price            float64 `gorm:"column:price" json:"price"`
	Num              int     `gorm:"column:num" json:"num"`
	SuccessNum       int     `gorm:"column:success_num" json:"success_num"`
	SurplusNum       int     `gorm:"column:surplus_num" json:"surplus_num"`
	RevokeNum        int     `gorm:"column:revoke_num" json:"revoke_num"`
	QueueHandleNum   int     `gorm:"column:queue_handle_num" json:"queue_handle_num"`
	SuccessHandleNum int     `gorm:"column:success_handle_num" json:"success_handle_num"`
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
func Pagination(ctx *gin.Context) (response PaginationResponse) {
	var list []Build
	pageNo, _ := strconv.Atoi(ctx.DefaultQuery("page", "1"))
	pageSizeNo, _ := strconv.Atoi(ctx.DefaultQuery("page_size", "10"))

	// 总数
	var total int64
	Query().Count(&total)

	// 分页查询
	Query().Offset((pageNo - 1) * pageSizeNo).Limit(pageSizeNo).Find(&list)
	// 响应
	response = PaginationResponse{
		Page:     pageNo,
		PageSize: pageSizeNo,
		Total:    total,
		List:     list,
	}
	return response
}
