package Model

type InfoLog struct {
	Model
	InfoId uint   `gorm:"column:info_id" json:"info_id"`
	Remark string `gorm:"column:remark" json:"remark"`
}
