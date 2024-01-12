package route

import (
	"github.com/gin-gonic/gin"
	Info "vgo/controller"
)

// CollectRoute 注册路由
func CollectRoute(app *gin.Engine) *gin.Engine {
	app.GET("/info", Info.Index)
	return app
}
