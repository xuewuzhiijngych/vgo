package app

import (
	AdminUserRouter "ych/vgo/app/AdminUser/Router"
	ArticleRouter "ych/vgo/app/Article/Router"
	CommonRouter "ych/vgo/app/Common/Router"
	WsRouter "ych/vgo/app/ws/Router"
)

func InitRouter() {
	CommonRouter.CollectRoutes()
	AdminUserRouter.CollectRoutes()
	WsRouter.CollectRoutes()
	ArticleRouter.CollectRoutes()
}
