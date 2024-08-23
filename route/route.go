package route

import (
	"github.com/gin-gonic/gin"
	"time"
	"vgo/controller"
	"vgo/controller/ProductOrder"
	"vgo/controller/Test"
	"vgo/core/middle"
	"vgo/core/middle/auth"
)

// CollectRoute 注册路由
func CollectRoute(app *gin.Engine) *gin.Engine {
	admin := app.Group("/admin")
	admin.POST("/user/get_token", controller.GetToken)
	admin.POST("/user/set_back", controller.Setback)
	admin.Use(auth.AdminAuthMiddleware())
	{
		admin.GET("/user/info", controller.UserInfo)

		admin.GET("/info", controller.Index)
		//app.POST("/info/create", Info.Create)
		admin.GET("/info/detail", controller.Detail)

		admin.GET("/product_order", ProductOrder.Index)
		admin.GET("/product_order/detail", middle.RateLimiter(1, time.Second), ProductOrder.Detail)

		admin.GET("/test", Test.Index)
	}
	return app
}
