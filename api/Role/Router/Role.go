package Role

import (
	Role "vgo/api/Role/Bapi"
	"vgo/internal/router"
)

func CollectRoutes() []router.BaseRoute {
	return []router.BaseRoute{
		{"GET", "/role", Role.Index},
		{"POST", "/role/create", Role.Create},
		{"POST", "/role/update", Role.Update},
		{"POST", "/role/delete", Role.Delete},
		{"GET", "/role/allDataSource", Role.GetAll},
		{"POST", "/role/set/menu", Role.SetMenu},
		{"POST", "/role/get/menu", Role.GetMenu},
	}
}
