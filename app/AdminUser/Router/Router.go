package Router

import (
	"ych/vgo/app/AdminUser/Bapi"
	"ych/vgo/internal/global"
)

func CollectRoutes() {
	global.Engine.POST("/user/login", Bapi.Login)
}
