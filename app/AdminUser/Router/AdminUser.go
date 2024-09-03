package AdminUser

import (
	AdminUser "vgo/app/AdminUser/Bapi"
	"vgo/core/router"
)

func CollectRoutes() []router.BaseRoute {
	return []router.BaseRoute{
		{"GET", "/admin_user", AdminUser.Index},
		{"POST", "/admin_user/create", AdminUser.Create},
		{"POST", "/admin_user/set/role", AdminUser.SetRole},
		{"POST", "/admin_user/get/role", AdminUser.GetRole},
		{"POST", "/admin_user/delete", AdminUser.Delete},
		{"POST", "/admin_user/logout", AdminUser.LogOut},
	}
}
