package route

import (
	"github.com/gin-gonic/gin"
	"time"
	"vgo/controller"
	"vgo/controller/Info"
	"vgo/core/middle"
)

// CollectRoute 注册路由
func CollectRoute(app *gin.Engine) *gin.Engine {
	AntiShake := middle.RateLimiter(1, time.Second) // 防抖

	app.GET("/user/info", controller.UserInfo)

	app.GET("/info", Info.Index)
	app.Use(AntiShake).Any("/info/detail", Info.Detail)

	return app
}
