package Router

import (
	"ych/vgo/app/Role/Backend"
)

func CollectRoutes() {
	Backend.RegisterRoleRoutes()
}
