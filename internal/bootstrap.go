package internal

import (
	"ych/vgo/internal/bootstrap"
	"ych/vgo/internal/global"
)

func Run() {
	// 初始化配置
	global.InitConfig()

	// 初始化日志
	go func() {
		bootstrap.InitLogger()
	}()

	// 初始化数据库
	bootstrap.InitDB()

	// 初始化Redis
	bootstrap.InitRedis()

	// 运行引导程序
	bootstrap.Run()
}
