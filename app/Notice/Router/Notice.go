package Router

import (
	"ych/vgo/app/Notice/Api"
	"ych/vgo/app/Notice/Backend"
	"ych/vgo/internal/global"
)

func CollectRoutes() {
	global.BackendRouter.GET("/notices", Backend.Index)
	global.BackendRouter.POST("/notices", Backend.Create)
	global.BackendRouter.PUT("/notices", Backend.Update)
	global.BackendRouter.GET("/notices/:id", Backend.Show)
	global.BackendRouter.DELETE("/notices", Backend.Delete)
	global.BackendRouter.POST("/notices/change", Backend.Change)

	global.ApiRouter.GET("/notices", Api.Index)
	global.ApiRouter.GET("/notices/:id", Api.Show)
}
