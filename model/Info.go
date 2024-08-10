package Model

import (
	"gorm.io/gorm"
)

type Info struct {
	gorm.Model
	Name     string    `gorm:"column:name" json:"name"`
	Age      int       `gorm:"column:age" json:"age"`
	InfoLog  []InfoLog `gorm:"foreignKey:InfoId"`
	InfoCard InfoCard  `gorm:"foreignKey:InfoId"`
	Str      string
}
