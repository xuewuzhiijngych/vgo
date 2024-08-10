package route

import (
	"github.com/gin-gonic/gin"
	"time"
	"vgo/controller"
	"vgo/controller/ProductOrder"
	"vgo/controller/Test"
	"vgo/core/middle"
)

// CollectRoute 注册路由
func CollectRoute(app *gin.Engine) *gin.Engine {
	app.GET("/user/info", controller.UserInfo)

	app.GET("/info", controller.Index)
	//app.POST("/info/create", Info.Create)
	app.GET("/info/detail", controller.Detail)

	app.GET("/product_order", ProductOrder.Index)
	app.GET("/product_order/detail", middle.RateLimiter(1, time.Second), ProductOrder.Detail)

	app.GET("/test", Test.Index)

	return app
}
