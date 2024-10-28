package app

import (
	AdminUserRouter "ych/vgo/app/AdminUser/Router"
	ArticleRouter "ych/vgo/app/Article/Router"
	CommonRouter "ych/vgo/app/Common/Router"
	UploadRouter "ych/vgo/app/Upload/Router"
	wsRouter "ych/vgo/app/ws/Router"
)

func InitRouter() {
	AdminUserRouter.CollectRoutes()
	CommonRouter.CollectRoutes()
	ArticleRouter.CollectRoutes()
	wsRouter.CollectRoutes()
	UploadRouter.CollectRoutes()
}
