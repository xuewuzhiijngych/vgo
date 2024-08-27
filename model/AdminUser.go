package Model

type AdminUser struct {
	Model
	UserName string `gorm:"column:username;unique;index;default:'';type:varchar(20);not null;comment:用户名" form:"username" json:"username"`
	Password string `gorm:"column:password;default:'';not null;comment:密码" form:"password" json:"password"`
}
