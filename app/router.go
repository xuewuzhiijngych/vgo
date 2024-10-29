package app

import (
	AdminUserRouter "ych/vgo/app/AdminUser/Router"
	ArticleRouter "ych/vgo/app/Article/Router"
	CommonRouter "ych/vgo/app/Common/Router"
	UploadRouter "ych/vgo/app/Upload/Router"
	WsRouter "ych/vgo/app/Ws/Router"
	"ych/vgo/internal/global"
)

func InitRouter() {
	global.BackendRouter = global.Engine.Group("/backend")
	global.ApiRouter = global.Engine.Group("/api/v1")

	AdminUserRouter.CollectRoutes()
	CommonRouter.CollectRoutes()
	ArticleRouter.CollectRoutes()
	WsRouter.CollectRoutes()
	UploadRouter.CollectRoutes()
}
