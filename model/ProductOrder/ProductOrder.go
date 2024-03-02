package ProductOrder

import (
	"gorm.io/gorm"
	"vgo/core/db"
)

var TableName = "product_orders"

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

func Query() (tx *gorm.DB) {
	return db.GetCon().Table(TableName)
}
