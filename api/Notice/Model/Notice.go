package Notice

import Common "vgo/api/Common/Model"

// Notice 公告
type Notice struct {
	Common.Model
	Title   string `gorm:"type:varchar(255);not null;column:title;default:'';comment:标题;" json:"title"`
	Type    int    `gorm:"type:smallint;not null;column:type;default:0;comment:公告类型（1通知 2公告）;" json:"type"`
	Status  int    `gorm:"column:status;type:smallint;not null;default:1;comment:状态 (1启用 2禁用)" json:"status"`
	Content string `gorm:"type:text;column:content;comment:公告内容;" json:"content"`
	Remark  string `gorm:"type:varchar(255);column:remark;default:'';comment:备注;" json:"remark"`
}
