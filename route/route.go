package route

import (
	"github.com/gin-gonic/gin"
	"time"
	Info "vgo/controller"
	"vgo/core/middle"
)

// CollectRoute 注册路由
func CollectRoute(app *gin.Engine) *gin.Engine {
	AntiShake := middle.RateLimiter(1, time.Second) // 防抖

	// 登录
	app.POST("/login", middle.AuthMiddleware.LoginHandler)

	app.GET("/info", Info.Index)
	app.Use(AntiShake).Any("/info/detail", Info.Detail)

	return app
}
