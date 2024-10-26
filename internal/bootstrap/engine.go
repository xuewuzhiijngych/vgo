package bootstrap

import (
	"github.com/gin-gonic/gin"
	"log"
	"ych/vgo/app"
	"ych/vgo/internal/global"
	"ych/vgo/internal/pkg/middleware/requestLogger"
)

// Run 启动
func Run() {
	appConfig := global.Config.App
	if appConfig.Env == "release" {
		gin.SetMode(gin.ReleaseMode)
	}
	global.Engine = gin.Default()

	if appConfig.RequestLog == 1 {
		global.Engine.Use(requestLogger.GetLogger())
	}

	global.Engine.Any("/test", app.Test)

	err := global.Engine.Run(appConfig.Host + ":" + appConfig.Port)
	if err != nil {
		log.Fatal(err)
		return
	}
}
