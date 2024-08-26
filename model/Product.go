package Model

type Product struct {
	Model
	Name   string  `gorm:"column:name;default:'';type:varchar(255);not null;comment:产品名" form:"name" json:"name"`
	Status uint8   `gorm:"column:status;default:1;not null;comment:状态:1-上架，2-下架" json:"status"`
	Stock  uint64  `gorm:"column:stock;default:0;not null;comment:库存" form:"stock" json:"stock"`
	Price  float64 `gorm:"column:price;type:decimal(10,2);:default:0;not null;comment:价格" form:"price" json:"price"`
}
