package Router

import (
	"ych/vgo/app/AdminUser/Backend"
	"ych/vgo/internal/global"
)

func CollectRoutes() {
	global.BackendRouter.POST("/user/login", Backend.Login)
}
