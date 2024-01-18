package bootstrap

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"vgo/core/db"
	"vgo/core/log"
	"vgo/core/redis"
	"vgo/global"
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
	route.CollectRoute(app)
	err := app.Run(":" + appConf.Port)
	if err != nil {
		fmt.Println(err)
		return
	}
}
