package internal

import (
	"ych/vgo/internal/bootstrap"
)

func Run() {
	// 初始化配置
	bootstrap.InitConfig()

	// 初始化日志
	go func() {
		bootstrap.InitLogger()
	}()

	// 初始化队列
	go func() {
		bootstrap.InitQueue()
	}()

	// 初始化数据库
	bootstrap.InitDB()

	// 初始化Redis
	bootstrap.InitRedis()

	// 运行引导程序
	bootstrap.Run()
}
