package Router

import (
	"ych/vgo/app/Ws/Api"
	"ych/vgo/internal/global"
)

func CollectRoutes() {
	global.Engine.GET("/Ws/link", Api.Link)
	global.Engine.POST("/Ws/send", Api.Send)
	global.Engine.POST("/Ws/send_to_all", Api.SendToAll)
}
