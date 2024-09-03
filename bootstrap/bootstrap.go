package bootstrap

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"runtime"
	"strconv"
	"time"
	"vgo/core/db"
	"vgo/core/global"
	"vgo/core/log"
	"vgo/core/middle"
	"vgo/core/middle/auth"
	"vgo/core/queue"
	"vgo/core/redis"
	"vgo/route"
)

func Start() {
	global.App.Config.InitConfig()

	appConf := global.App.Config.App
	cpuNum, _ := strconv.Atoi(global.App.Config.App.CpuNum)
	realCpuNum := runtime.NumCPU()
	if cpuNum > realCpuNum {
		cpuNum = realCpuNum
	}
	if appConf.Env == "dev" {
		if cpuNum > 0 {
			runtime.GOMAXPROCS(cpuNum)
			fmt.Printf("当前计算机核数: %v个,调用：%v个\n", realCpuNum, cpuNum)
		} else {
			runtime.GOMAXPROCS(realCpuNum)
			fmt.Printf("当前计算机核数: %v个,调用：%v个\n", realCpuNum, cpuNum)
		}
	}

	log.InitLog()
	db.InitCon()
	redis.InitCon()
	queueConf := global.App.Config.QueueConf
	if queueConf.Enable == 1 {
		// 运行 Asynq 任务队列
		go func() {
			queue.InitQueue()
		}()
	}
	jwtConf := global.App.Config.JwtConf
	auth.AdminTokenExpireDuration = time.Duration(jwtConf.AdminTimeout) * time.Hour
	auth.ApiTokenExpireDuration = time.Duration(jwtConf.ApiTimeout) * time.Hour
	auth.AdminSecret = []byte(jwtConf.AdminKey)
	auth.ApiSecret = []byte(jwtConf.ApiKey)

	app := gin.Default()
	// 请求日志
	if appConf.RequestLog == 1 {
		app.Use(middle.RequestLogger())
	}
	if appConf.Env == "pro" {
		gin.SetMode(gin.ReleaseMode)
	}
	// 收集路由
	route.CollectRoute(app)
	err := app.Run(appConf.Host + ":" + appConf.Port)
	if err != nil {
		fmt.Println(err)
		return
	}
}
