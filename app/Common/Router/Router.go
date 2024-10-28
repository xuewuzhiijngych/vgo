package Router

import (
	"ych/vgo/app/Common/Api"
	"ych/vgo/internal/global"
)

func CollectRoutes() {
	global.Engine.GET("/test", Api.Test)
}
