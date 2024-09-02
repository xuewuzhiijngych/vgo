package route

import (
	"github.com/gin-gonic/gin"
	AdminUserController "vgo/app/AdminUser/Bapi"
	AdminUser "vgo/app/AdminUser/Router"
	Common "vgo/app/Common/Bapi"
	Menu "vgo/app/Menu/Router"
	Notice "vgo/app/Notice/Router"
	System "vgo/app/System/Bapi"
	"vgo/app/Test"
	UserController "vgo/app/User/Api"
	User "vgo/app/User/Router"
	"vgo/core/middle/auth"
	"vgo/core/router"
)

// CollectRoute 注册路由
func CollectRoute(app *gin.Engine) *gin.Engine {
	app.GET("/test", Test.Index)

	admin := app.Group("/admin")
	admin.GET("/common/get_gender", Common.GetGender)
	admin.GET("/system/getBingBackgroundImage", System.GetBingBackgroundImage)
	admin.POST("/admin_user/login", AdminUserController.Login)
	bapiRouters := router.CollectRoutesFromModules(
		Notice.CollectRoutes,
		Menu.CollectRoutes,
		AdminUser.CollectRoutes,
	)
	admin.Use(auth.AdminAuthMiddleware())
	{
		for _, route := range bapiRouters {
			admin.Handle(route.Method, route.Path, route.Handler)
		}
		//admin.GET("/product_order/detail", middle.RateLimiter(1, time.Second), ProductOrder.Detail)
	}

	api := app.Group("/api")
	api.POST("/user/get_token", UserController.GetToken)
	api.POST("/user/set_back", UserController.Setback)
	apiRouters := router.CollectRoutesFromModules(
		User.CollectRoutes,
	)
	api.Use(auth.UserAuthMiddleware())
	{
		for _, route := range apiRouters {
			api.Handle(route.Method, route.Path, route.Handler)
		}
	}
	return app
}
