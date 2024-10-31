package Router

import (
	"ych/vgo/app/Menu/Backend"
	"ych/vgo/internal/global"
)

func CollectRoutes() {
	global.BackendRouter.GET("/menu/list", Backend.Index)
	global.BackendRouter.GET("/menu/selectTreeDataSource", Backend.GetSelectTree)
	global.BackendRouter.POST("/menu/create", Backend.Create)
	global.BackendRouter.POST("/menu/update", Backend.Update)
	global.BackendRouter.POST("/menu/delete", Backend.Delete)
	global.BackendRouter.GET("/button/list", Backend.Buttons)
}
