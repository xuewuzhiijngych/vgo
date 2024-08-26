package Model

type CardLog struct {
	Model
	CardId uint   `gorm:"column:card_id" json:"card_id"`
	Name   string `gorm:"column:name" json:"name"`
	Status uint   `gorm:"column:status" json:"status"`
}
