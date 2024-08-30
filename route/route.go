package route

import (
	"github.com/gin-gonic/gin"
	"time"
	"vgo/controller/ApiController"
	"vgo/controller/BapiController"
	"vgo/controller/BapiController/AdminUser"
	"vgo/controller/BapiController/Info"
	"vgo/controller/BapiController/Menu"
	"vgo/controller/BapiController/Notice"
	"vgo/controller/BapiController/Product"
	"vgo/controller/BapiController/ProductOrder"
	"vgo/controller/BapiController/System"
	"vgo/controller/Common"
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

	admin.GET("/common/get_gender", Common.GetGender)

	admin.POST("/admin_user/create", AdminUser.Create)
	admin.POST("/admin_user/login", AdminUser.Login)

	admin.Use(auth.AdminAuthMiddleware())
	{
		admin.POST("/admin_user/logout", AdminUser.LogOut)
		admin.GET("/menu/list", Menu.Index)
		admin.GET("/button/list", Menu.Buttons)

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

		admin.GET("/notice", Notice.Index)
		admin.GET("/notice/detail", Notice.Detail)
		admin.POST("/notice/create", Notice.Create)
		admin.POST("/notice/update", Notice.Update)
		admin.POST("/notice/change", Notice.Change)
		admin.POST("/notice/delete/:id", Notice.Delete)

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

// RegisterBaseRoutes 基本路由注册函数
func RegisterBaseRoutes(group *gin.RouterGroup, path string, handlers ...gin.HandlerFunc) {
	group.GET(path, handlers...)
	group.GET(path+"/detail", handlers...)
	group.POST(path+"/create", handlers...)
	group.POST(path+"/update/:id", handlers...)
	group.POST(path+"/delete/:id", handlers...)
}
