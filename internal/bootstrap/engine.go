package bootstrap

import (
	"github.com/gin-gonic/gin"
	"log"
	"ych/vgo/app"
	"ych/vgo/internal/global"
	"ych/vgo/internal/middleware/requestLogger"
)

// Run 启动
func Run() {
	if global.Config.App.Env == "release" {
		gin.SetMode(gin.ReleaseMode)
	}
	global.Engine = gin.Default()

	global.Engine.Use(requestLogger.GetLogger())

	global.Engine.Any("/test", app.Test)

	appConfig := global.Config.App
	err := global.Engine.Run(appConfig.Host + ":" + appConfig.Port)
	if err != nil {
		log.Fatal(err)
		return
	}
}
