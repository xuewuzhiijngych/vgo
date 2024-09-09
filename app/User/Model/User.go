package User

import (
	Common "vgo/app/Common/Model"
)

// User 用户
type User struct {
	Common.Model
	Phone    string `gorm:"column:phone;default:'';type:varchar(11);not null;comment:手机" form:"phone" json:"phone"`
	Password string `gorm:"column:password;default:'';not null;comment:密码" form:"password" json:"password"`
	PId      uint64 `gorm:"column:pid;type:bigint;not null;default:0;comment:父ID" json:"pid"`
}
