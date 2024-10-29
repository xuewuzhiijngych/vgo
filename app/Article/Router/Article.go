package Router

import (
	"ych/vgo/app/Article/Api"
	"ych/vgo/app/Article/Backend"
	"ych/vgo/internal/global"
)

func CollectRoutes() {
	//global.BackendRouter.GET("/article/index", Backend.Index)
	//global.BackendRouter.POST("/article/create", Backend.Create)
	//global.BackendRouter.POST("/article/update", Backend.Update)
	//global.BackendRouter.GET("/article/show", Backend.Show)
	//global.BackendRouter.POST("/article/delete", Backend.Delete)
	Backend.RegisterArticleRoutes()

	global.ApiRouter.GET("/article/index", Api.Index)
	global.ApiRouter.POST("/article/create", Api.Create)
	global.ApiRouter.POST("/article/update", Api.Update)
	global.ApiRouter.GET("/article/show", Api.Show)
	global.ApiRouter.POST("/article/delete", Api.Delete)
}
