package Role

import (
	Common "vgo/app/Common/Model"
)

// Role 角色
type Role struct {
	Common.Model
	Name string `gorm:"column:name;type:varchar(50);not null;default:'';comment:角色名称" json:"name"`
	Code string `gorm:"column:code;type:varchar(50);unique;not null;default:'';comment:角色代码" json:"code"`
}
