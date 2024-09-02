package Role

import (
	Common "vgo/app/Common/Model"
)

// Role 角色
type Role struct {
	Common.Model
	Name string `gorm:"column:name;type:varchar(50);not null;default:'';comment:路由name" json:"name"`
}
