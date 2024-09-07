package Tpl

import (
	Tpl "vgo/app/Tpl/Bapi"
	"vgo/core/router"
)

func CollectRoutes() []router.BaseRoute {
	return []router.BaseRoute{
		{"GET", "/tpl", Tpl.Index},
		{"POST", "/tpl/create", Tpl.Create},
		{"POST", "/tpl/update", Tpl.Update},
		{"POST", "/tpl/delete", Tpl.Delete},
	}
}
