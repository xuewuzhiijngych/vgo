package app

import (
	AdminUserRouter "ych/vgo/app/AdminUser/Router"
	ArticleRouter "ych/vgo/app/Article/Router"
	CommonRouter "ych/vgo/app/Common/Router"
	MenuRouter "ych/vgo/app/Menu/Router"
	NoticeRouter "ych/vgo/app/Notice/Router"
	RoleRouter "ych/vgo/app/Role/Router"
	UploadRouter "ych/vgo/app/Upload/Router"
	WsRouter "ych/vgo/app/Ws/Router"
	"ych/vgo/internal/global"
	"ych/vgo/internal/pkg/middleware/auth"
	"ych/vgo/internal/pkg/middleware/permission"
)

func InitRouter() {
	global.BackendRouter = global.Engine.Group("/backend")
	global.BackendRouter.Use(auth.AdminAuthMiddleware(), permission.Check(global.Rbac))

	global.ApiRouter = global.Engine.Group("/api/v1")

	ArticleRouter.CollectRoutes()
	NoticeRouter.CollectRoutes()

	AdminUserRouter.CollectRoutes()
	CommonRouter.CollectRoutes()
	WsRouter.CollectRoutes()
	UploadRouter.CollectRoutes()

	MenuRouter.CollectRoutes()
	RoleRouter.CollectRoutes()
}
