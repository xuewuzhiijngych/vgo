package Menu

import (
	Menu "vgo/api/Menu/Bapi"
	"vgo/internal/router"
)

func CollectRoutes() []router.BaseRoute {
	return []router.BaseRoute{
		{"GET", "/menu/list", Menu.Index},
		{"GET", "/menu/selectTreeDataSource", Menu.GetSelectTree},
		{"POST", "/menu/create", Menu.Create},
		{"POST", "/menu/update", Menu.Update},
		{"POST", "/menu/delete", Menu.Delete},
		{"GET", "/button/list", Menu.Buttons},
	}
}
