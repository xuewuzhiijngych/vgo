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
	"vgo/core/snow"
	"vgo/route"
)

func Start() {
	global.App.Config.InitConfig()
	appConfig := global.App.Config

	appConf := appConfig.App
	cpuNum, _ := strconv.Atoi(appConfig.App.CpuNum)
	realCpuNum := runtime.NumCPU()
	if cpuNum > realCpuNum {
		cpuNum = realCpuNum
	}
	if appConf.Env == "dev" {
		if cpuNum > 0 {
			runtime.GOMAXPROCS(cpuNum)
			fmt.Printf("计算机核数: %v个,调用：%v个\n", realCpuNum, cpuNum)
		} else {
			runtime.GOMAXPROCS(realCpuNum)
			fmt.Printf("计算机核数: %v个,调用：%v个\n", realCpuNum, cpuNum)
		}
	}

	// 初始化数据库
	db.InitCon()

	// 初始化redis
	redis.InitCon()

	// 初始化日志
	go func() {
		log.InitLog()
	}()

	// 初始化雪花算法
	go func() {
		snow.InitSnowflake()
	}()

	// 是否需要队列
	queueConf := appConfig.QueueConf
	if queueConf.Enable == 1 {
		// 运行 Asynq 任务队列
		go func() {
			queue.InitQueue()
		}()
	}

	// jwt相关配置
	jwtConf := appConfig.JwtConf
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

	// 静态资源
	app.Static("/storage", "storage")

	// 收集路由
	route.CollectRoute(app)
	err := app.Run(appConf.Host + ":" + appConf.Port)
	if err != nil {
		fmt.Println(err)
		return
	}
}
