package Role

import (
	Role "vgo/app/Role/Bapi"
	"vgo/core/router"
)

func CollectRoutes() []router.BaseRoute {
	return []router.BaseRoute{
		{"GET", "/role", Role.Index},
		{"POST", "/role/create", Role.Create},
		{"POST", "/role/update", Role.Update},
		{"POST", "/role/delete/:id", Role.Delete},
	}
}
