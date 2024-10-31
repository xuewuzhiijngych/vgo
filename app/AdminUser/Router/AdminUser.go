package Router

import (
	"ych/vgo/app/AdminUser/Backend"
	"ych/vgo/internal/global"
)

func CollectRoutes() {
	global.Engine.Group("/backend").POST("/user/login", Backend.Login)
}
