package Notice

import (
	Notice "vgo/api/Notice/Bapi"
	"vgo/internal/router"
)

func CollectRoutes() []router.BaseRoute {
	return []router.BaseRoute{
		{"GET", "/notice", Notice.Index},
		{"POST", "/notice/create", Notice.Create},
		{"POST", "/notice/update", Notice.Update},
		{"POST", "/notice/change", Notice.Change},
		{"POST", "/notice/delete", Notice.Delete},
	}
}
