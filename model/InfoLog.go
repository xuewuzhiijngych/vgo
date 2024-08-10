package Model

import (
	"gorm.io/gorm"
)

type InfoLog struct {
	gorm.Model
	InfoId uint   `gorm:"column:info_id" json:"info_id"`
	Remark string `gorm:"column:remark" json:"remark"`
}
