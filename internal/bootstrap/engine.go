package bootstrap

import (
	"github.com/gin-gonic/gin"
	"log"
	"ych/vgo/app"
	"ych/vgo/internal/global"
)

// Run 启动
func Run() {
	global.Engine = gin.Default()

	global.Engine.Any("/test", app.Test)

	appConfig := global.Config.App
	err := global.Engine.Run(appConfig.Host + ":" + appConfig.Port)
	if err != nil {
		log.Fatal(err)
		return
	}
	return
}
