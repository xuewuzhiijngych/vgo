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

	// 找不到路由
	app.NoRoute(func(c *gin.Context) {
		path := c.Request.URL.Path
		method := c.Request.Method
		c.JSON(404, gin.H{"code": 404, "message": "请求方式：" + method + " 请求地址：" + path + "不存在！！！"})
	})

	route.CollectRoute(app)
	err := app.Run(appConf.Domain + ":" + appConf.Port)
	if err != nil {
		fmt.Println(err)
		return
	}
}
