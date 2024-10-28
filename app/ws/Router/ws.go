package Router

import (
	"ych/vgo/app/ws"
	"ych/vgo/internal/global"
)

func CollectRoutes() {
	global.Engine.GET("/ws/link", ws.Link)
	global.Engine.POST("/ws/send", ws.Send)
	global.Engine.POST("/ws/send_to_all", ws.SendToAll)
}
