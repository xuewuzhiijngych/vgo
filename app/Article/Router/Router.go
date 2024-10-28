package Router

import (
	"ych/vgo/app/Article/Api"
	"ych/vgo/app/Article/Bapi"
	"ych/vgo/internal/global"
)

func CollectRoutes() {
	baseBapiUri := "bapi/article"
	global.Engine.GET("/"+baseBapiUri+"/index", Bapi.Index)
	global.Engine.POST("/"+baseBapiUri+"/create", Bapi.Create)
	global.Engine.POST("/"+baseBapiUri+"/update", Bapi.Update)
	global.Engine.GET("/"+baseBapiUri+"/show", Bapi.Show)
	global.Engine.POST("/"+baseBapiUri+"/delete", Bapi.Delete)

	baseApiUri := "api/article"
	global.Engine.GET("/"+baseApiUri+"/index", Api.Index)
	global.Engine.POST("/"+baseApiUri+"/create", Api.Create)
	global.Engine.POST("/"+baseApiUri+"/update", Api.Update)
	global.Engine.GET("/"+baseApiUri+"/show", Api.Show)
	global.Engine.POST("/"+baseApiUri+"/delete", Api.Delete)
}
