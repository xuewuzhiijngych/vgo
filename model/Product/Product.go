package Product

import (
	"time"
)

type Product struct {
	ID        uint      `gorm:"primary_key"  json:"id"`
	Name      string    `gorm:"column:name" json:"name"`
	Status    string    `gorm:"column:status" json:"status"`
	Stock     int       `gorm:"column:stock" json:"stock"`
	Price     float64   `gorm:"column:price" json:"price"`
	CreatedAt time.Time `gorm:"column:created_at" json:"created_at"`
	UpdateAt  time.Time `gorm:"column:update_at" json:"update_at"`
}
