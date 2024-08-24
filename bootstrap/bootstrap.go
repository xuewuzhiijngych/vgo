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
	"vgo/core/redis"
	"vgo/core/response"
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

	// 全局限流
	//app.Use(middle.RateLimiter(60, time.Second*60))

	// 找不到路由
	app.NoRoute(func(c *gin.Context) {
		path := c.Request.URL.Path
		method := c.Request.Method
		response.Fail(c, "请求方式："+method+" 请求地址："+path+"不存在！！！", map[string]interface{}{
			"HttpCode": 404,
		}, nil)
	})

	route.CollectRoute(app)
	err := app.Run(appConf.Host + ":" + appConf.Port)
	if err != nil {
		fmt.Println(err)
		return
	}
}
