package Info

import (
	"gorm.io/gorm"
	"vgo/core/db"
)

var TableName = "infos"

type Build struct {
	ID          uint   `gorm:"primary_key"  json:"id"`
	Name        string `gorm:"column:name" json:"name"`
	HiddenField string `gorm:"column:hidden_field" json:"-"`
	CreatedAt   int    `gorm:"column:created_at" json:"created_at"`
	Str         string `json:"str"`
}

func Query() (tx *gorm.DB) {
	return db.GetCon().Table(TableName)
}
