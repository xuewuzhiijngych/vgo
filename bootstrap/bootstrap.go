package bootstrap

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"vgo/db"
	"vgo/global"
	"vgo/log"
	"vgo/route"
)

func Start() {
	global.App.Config.InitConfig()
	db.MyInit()
	log.MyInit()
	
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
