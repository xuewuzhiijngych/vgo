package bootstrap

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"time"
	"vgo/core/db"
	"vgo/core/global"
	"vgo/core/log"
	"vgo/core/middle"
	"vgo/core/redis"
	"vgo/core/response"
	"vgo/route"
)

func Start() {
	global.App.Config.InitConfig()
	log.MyInit()
	db.MyInit()
	redis.MyInit()

	appConf := global.App.Config.App
	if appConf.Env == "pro" {
		gin.SetMode(gin.ReleaseMode)
	}

	app := gin.Default()

	// 请求日志
	if appConf.RequestLog == 1 {
		app.Use(middle.RequestLogger())
	}

	// 限流
	app.Use(middle.RateLimiter(60, time.Second*60))

	// 登录
	app.POST("/login", middle.AuthMiddleware.LoginHandler)

	// JWT验证
	app.Use(middle.AuthMiddleware.MiddlewareFunc())

	app.GET("/refresh_token", middle.AuthMiddleware.RefreshHandler)

	// 找不到路由
	app.NoRoute(func(c *gin.Context) {
		path := c.Request.URL.Path
		method := c.Request.Method
		response.Fail(c, "请求方式："+method+" 请求地址："+path+"不存在！！！", map[string]interface{}{
			"HttpCode": 404,
		}, nil)
	})

	route.CollectRoute(app)
	err := app.Run(appConf.Domain + ":" + appConf.Port)
	if err != nil {
		fmt.Println(err)
		return
	}
}
