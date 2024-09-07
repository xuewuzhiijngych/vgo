package route

import (
	"github.com/gin-gonic/gin"
	AdminUserController "vgo/app/AdminUser/Bapi"
	AdminUser "vgo/app/AdminUser/Router"
	Common "vgo/app/Common/Bapi"
	Menu "vgo/app/Menu/Router"
	Notice "vgo/app/Notice/Router"
	Role "vgo/app/Role/Router"
	System "vgo/app/System/Bapi"
	"vgo/app/Test"
	UserController "vgo/app/User/Api"
	User "vgo/app/User/Router"
	"vgo/app/Ws"
	"vgo/core/middle/auth"
	"vgo/core/middle/casbin"
	"vgo/core/middle/cors"
	"vgo/core/response"
	"vgo/core/router"
)

// CollectRoute 注册路由
func CollectRoute(app *gin.Engine) *gin.Engine {
	// 全局限流
	//app.Use(middle.RateLimiter(60, time.Second*60))

	// 找不到路由
	app.NoRoute(func(c *gin.Context) {
		path := c.Request.URL.Path
		method := c.Request.Method
		response.Fail(c, "请求方式："+method+" 请求地址："+path+"不存在！！！", map[string]interface{}{
			"HttpCode": 404,
		}, nil)
	})

	app.GET("/test", Test.Index)
	app.GET("/test2", Test.Index2)

	app.GET("/ws/link", Ws.Link)
	app.POST("/ws/send", Ws.Send)

	admin := app.Group("/admin").Use(cors.BapiCors())
	admin.GET("/common/get_gender", Common.GetGender)
	admin.GET("/system/getBingBackgroundImage", System.GetBingBackgroundImage)
	admin.POST("/admin_user/login", AdminUserController.Login)
	bapiRouters := router.CollectRoutesFromModules(
		Notice.CollectRoutes,
		Menu.CollectRoutes,
		AdminUser.CollectRoutes,
		Role.CollectRoutes,
	)

	enforcer := casbin.SetupCasbin()
	admin.Use(auth.AdminAuthMiddleware(), casbin.CheckMiddleware(enforcer))
	{
		for _, route := range bapiRouters {
			admin.Handle(route.Method, route.Path, route.Handler)
		}

		//admin.GET("/product_order/detail", middle.RateLimiter(1, time.Second), ProductOrder.Detail)
	}

	api := app.Group("/api").Use(cors.ApiCors())
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
