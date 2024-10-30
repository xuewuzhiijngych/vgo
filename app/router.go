package app

import (
	AdminUserRouter "ych/vgo/app/AdminUser/Router"
	ArticleRouter "ych/vgo/app/Article/Router"
	CommonRouter "ych/vgo/app/Common/Router"
	NoticeRouter "ych/vgo/app/Notice/Router"
	UploadRouter "ych/vgo/app/Upload/Router"
	WsRouter "ych/vgo/app/Ws/Router"
	"ych/vgo/internal/global"
)

func InitRouter() {
	global.BackendRouter = global.Engine.Group("/backend")
	global.ApiRouter = global.Engine.Group("/api/v1")

	ArticleRouter.CollectRoutes()
	NoticeRouter.CollectRoutes()

	AdminUserRouter.CollectRoutes()
	CommonRouter.CollectRoutes()
	WsRouter.CollectRoutes()
	UploadRouter.CollectRoutes()
}
