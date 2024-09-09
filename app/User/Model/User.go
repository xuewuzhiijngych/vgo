package User

import (
	Common "vgo/app/Common/Model"
)

// User 用户
type User struct {
	Common.Model
	Phone    string `gorm:"column:phone;default:'';type:varchar(11);not null;comment:手机" validate:"required" json:"phone"`
	Password string `gorm:"column:password;default:'';not null;comment:密码" validate:"required" json:"password"`
	PId      uint64 `gorm:"column:pid;type:bigint;not null;default:0;comment:父ID" validate:"required" json:"pid"`
	RealName string `gorm:"column:real_name;default:'';type:varchar(255);not null;comment:真实姓名" validate:"required" json:"real_name"`
	IdCard   string `gorm:"column:id_card;default:'';type:varchar(255);not null;comment:身份证号码" validate:"required" json:"id_card"`
}
