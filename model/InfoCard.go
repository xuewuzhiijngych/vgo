package Model

import (
	"gorm.io/gorm"
)

type InfoCard struct {
	gorm.Model
	InfoId  uint      `gorm:"column:info_id" json:"info_id"`
	Name    string    `gorm:"column:name" json:"name"`
	CardLog []CardLog `gorm:"foreignKey:CardId"`
}
