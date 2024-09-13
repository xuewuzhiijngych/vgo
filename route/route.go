package route

import (
	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"strings"
	"time"
	AdminUserController "vgo/app/AdminUser/Bapi"
	AdminUser "vgo/app/AdminUser/Router"
	Common "vgo/app/Common/Bapi"
	Menu "vgo/app/Menu/Router"
	Notice "vgo/app/Notice/Router"
	Role "vgo/app/Role/Router"
	System "vgo/app/System/Bapi"
	"vgo/app/Test"
	Upload "vgo/app/Upload/Router"
	UserController "vgo/app/User/Api"
	User "vgo/app/User/Router"
	"vgo/app/Ws"
	"vgo/core/global"
	"vgo/core/middle/auth"
	"vgo/core/middle/casbin"
	"vgo/core/response"
	"vgo/core/router"
)

// CollectRoute 注册路由
func CollectRoute(app *gin.Engine) *gin.Engine {
	// 全局限流
	//app.Use(middle.RateLimiter(60, time.Second*60))

	// 跨域处理
	origins := global.App.Config.App.ApiOrigins
	allowedOrigins := strings.Split(origins, ",")
	app.Use(cors.New(cors.Config{
		AllowOrigins:     allowedOrigins,
		AllowMethods:     []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
		AllowHeaders:     []string{"Origin", "Authorization", "Content-Type"},
		ExposeHeaders:    []string{"Content-Length"},
		AllowCredentials: true,
		MaxAge:           12 * time.Hour,
	}))

	// 找不到路由
	app.NoRoute(func(c *gin.Context) {
		response.Fail(c, "请求地址不存在！", nil)
	})
	// 找不到方法
	app.NoMethod(func(c *gin.Context) {
		response.Fail(c, "请求方法不存在！", nil)
	})

	app.GET("/test", Test.Index)
	app.POST("/test2", Test.Index2)

	app.GET("/ws/link", Ws.Link)
	app.POST("/ws/send", Ws.Send)
	app.POST("/ws/send_to_all", Ws.SendToAll)

	admin := app.Group("/admin")
	admin.GET("/common/get_gender", Common.GetGender)
	admin.GET("/system/getBingBackgroundImage", System.GetBingBackgroundImage)
	admin.POST("/admin_user/login", AdminUserController.Login)

	bapiRouters := router.CollectRoutesFromModules(
		Notice.CollectRoutes,
		Menu.CollectRoutes,
		AdminUser.CollectRoutes,
		Role.CollectRoutes,
		Upload.CollectRoutes,
	)

	enforcer := casbin.SetupCasbin()
	admin.Use(auth.AdminAuthMiddleware(), casbin.CheckMiddleware(enforcer))

	for _, route := range bapiRouters {
		admin.Handle(route.Method, route.Path, route.Handler)
	}

	api := app.Group("/api")
	api.POST("/user/register", UserController.Register)
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
