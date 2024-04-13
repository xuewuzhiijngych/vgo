package Info

import (
	"gorm.io/gorm"
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

// Query 查询
func Query() (tx *gorm.DB) {
	return db.GetCon().Table(TableName)
}
