package Model

import "ych/vgo/app/Common/Model"

type Notice struct {
	Model.BaseModel
	Title   string `gorm:"type:varchar(255);not null;column:title;default:'';comment:标题;" validate:"required" json:"title"`
	Content string `gorm:"type:text;column:content;comment:公告内容;" json:"content"`
}