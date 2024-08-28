package Model

import (
	"gorm.io/gorm"
)

// Menu 菜单
type Menu struct {
	Model
	ParentId  uint64                 `gorm:"column:parent_id;type:bigint;not null;default:0;comment:父ID" json:"parent_id"`
	Level     string                 `gorm:"column:level;type:varchar(500);not null;default:'';comment:组级集合" json:"level"`
	Name      string                 `gorm:"column:name;type:varchar(50);not null;default:'';comment:菜单名称" json:"name"`
	Code      string                 `gorm:"column:code;type:varchar(100);not null;default:'';comment:菜单标识代码" json:"code"`
	Icon      string                 `gorm:"column:icon;type:varchar(50);not null;default:'';comment:菜单图标" json:"icon"`
	Route     string                 `gorm:"column:route;type:varchar(200);not null;default:'';comment:路由地址" json:"route"`
	Component string                 `gorm:"column:component;type:varchar(255);not null;default:'';comment:组件路径" json:"component"`
	Redirect  string                 `gorm:"column:redirect;type:varchar(255);not null;default:'';comment:跳转地址" json:"redirect"`
	IsHidden  int                    `gorm:"column:is_hidden;type:smallint;not null;default:1;comment:是否隐藏 (1是 2否)" json:"is_hidden"`
	Type      string                 `gorm:"column:type;type:char(1);not null;default:'';comment:菜单类型, (M菜单 B按钮 L链接 I iframe)" json:"type"`
	Status    int                    `gorm:"column:status;type:smallint;not null;default:1;comment:状态 (1正常 2停用)" json:"status"`
	Sort      int                    `gorm:"column:sort;type:smallint;not null;default:0;comment:排序" json:"sort"`
	Remark    string                 `gorm:"column:remark;type:varchar(255);not null;default:'';comment:备注" json:"remark"`
	Meta      map[string]interface{} `gorm:"-"  json:"meta"` // 忽略数据库字段，使用Getter方法
	Path      string                 `gorm:"-"  json:"path"` // 忽略数据库字段，使用Getter方法
	Children  []Menu                 `gorm:"foreignKey:ParentId" json:"children"`
}

// AfterFind 回调函数，在查询后执行
func (m *Menu) AfterFind(tx *gorm.DB) (err error) {
	m.Meta = m.getMetaAttribute()
	m.Path = m.getPathAttribute()
	return
}

// GetMetaAttribute 获取菜单元数据属性
func (m *Menu) getMetaAttribute() map[string]interface{} {
	hidden := false
	if m.IsHidden == 1 {
		hidden = true
	}
	meta := map[string]interface{}{
		"hidden":           hidden,
		"hiddenBreadcrumb": false,
		"icon":             m.Icon,
		"title":            m.Name,
		"type":             m.Type,
	}
	return meta
}

// getPathAttribute 获取菜单路径属性
func (m *Menu) getPathAttribute() string {
	return "/" + m.Route
}

// BuildMenuTree 构建菜单树
func BuildMenuTree(menus []Menu, parentID uint64) []Menu {
	var tree []Menu
	for _, menu := range menus {
		if menu.ParentId == parentID {
			children := BuildMenuTree(menus, menu.ID)
			if len(children) > 0 {
				menu.Children = children
			}
			tree = append(tree, menu)
		}
	}
	return tree
}
