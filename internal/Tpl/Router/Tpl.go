package Tpl

import (
	"vgo/internal/Tpl/Bapi"
	"vgo/internal/router"
)

func CollectRoutes() []router.BaseRoute {
	return []router.BaseRoute{
		{"GET", "/tpl", Tpl.Index},
		{"POST", "/tpl/create", Tpl.Create},
		{"POST", "/tpl/update", Tpl.Update},
		{"POST", "/tpl/delete", Tpl.Delete},
	}
}
