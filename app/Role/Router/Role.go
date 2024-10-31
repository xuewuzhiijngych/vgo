package Router

import (
	"ych/vgo/app/Role/Backend"
	"ych/vgo/internal/global"
)

func CollectRoutes() {
	global.BackendRouter.GET("/role", Backend.Index)
	global.BackendRouter.POST("/role/create", Backend.Create)
	global.BackendRouter.POST("/role/update", Backend.Update)
	global.BackendRouter.POST("/role/delete", Backend.Delete)
	global.BackendRouter.GET("/role/allDataSource", Backend.GetAll)
	global.BackendRouter.POST("/role/set/menu", Backend.SetMenu)
	global.BackendRouter.POST("/role/get/menu", Backend.GetMenu)
}
