package route

import (
	"github.com/gin-gonic/gin"
	"time"
	"vgo/controller"
	"vgo/controller/Info"
	"vgo/controller/ProductOrder"
	"vgo/controller/Test"
	"vgo/core/middle"
)

// CollectRoute 注册路由
func CollectRoute(app *gin.Engine) *gin.Engine {
	app.GET("/user/info", controller.UserInfo)

	app.GET("/info", Info.Index)
	app.POST("/info/detail", Info.Detail)

	app.GET("/product_order", ProductOrder.Index)
	app.POST("/product_order/detail", middle.RateLimiter(1, time.Second), ProductOrder.Detail)

	app.GET("/test", Test.Index)

	return app
}
