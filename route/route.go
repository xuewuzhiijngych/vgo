package route

import (
	"github.com/gin-gonic/gin"
	"time"
	"vgo/controller/ApiController"
	"vgo/controller/BapiController"
	"vgo/controller/BapiController/AdminUser"
	"vgo/controller/BapiController/Info"
	"vgo/controller/BapiController/Product"
	"vgo/controller/BapiController/ProductOrder"
	"vgo/controller/BapiController/System"
	"vgo/controller/Test"
	"vgo/core/middle"
	"vgo/core/middle/auth"
)

// CollectRoute 注册路由
func CollectRoute(app *gin.Engine) *gin.Engine {
	app.GET("/test", Test.Index)

	admin := app.Group("/admin")
	admin.POST("/user/get_token", BapiController.GetToken)
	admin.POST("/user/set_back", BapiController.Setback)
	admin.GET("/system/getBingBackgroundImage", System.GetBingBackgroundImage)

	admin.POST("/admin_user/create", AdminUser.Create)
	admin.POST("/admin_user/login", AdminUser.Login)

	admin.Use(auth.AdminAuthMiddleware())
	{
		admin.GET("/system/getInfo", System.GetInfo)
		admin.GET("/user/info", BapiController.UserInfo)

		admin.GET("/info", Info.Index)
		//app.POST("/info/create", Info.Create)
		admin.GET("/info/detail", Info.Detail)

		admin.GET("/product", Product.Index)
		admin.GET("/product/detail", Product.Detail)
		admin.POST("/product/create", Product.Create)
		admin.POST("/product/update/:id", Product.Update)
		admin.POST("/product/delete/:id", Product.Delete)

		admin.GET("/product_order", ProductOrder.Index)
		admin.GET("/product_order/detail", middle.RateLimiter(1, time.Second), ProductOrder.Detail)
	}

	api := app.Group("/api")
	api.POST("/user/get_token", ApiController.GetToken)
	api.POST("/user/set_back", ApiController.Setback)
	api.Use(auth.UserAuthMiddleware())
	{
		api.GET("/user/info", ApiController.UserInfo)
	}
	return app
}
