package Router

import (
	"ych/vgo/app/AdminUser/Backend"
)

func CollectRoutes() {
	Backend.RegisterAdminUserRoutes()
}
