package core

import (
	"ych/vgo/internal/bootstrap"
)

func Run() {
	// 初始化配置
	bootstrap.InitConfig()

	// 初始化数据库
	bootstrap.InitDB()

	// 初始化Redis
	bootstrap.InitRedis()

	// 初始化RBAC
	bootstrap.InitRbac()

	// 初始化其他组件
	var initFunctions = []func(){
		bootstrap.InitLogger,
		bootstrap.InitQueue,
		bootstrap.InitValidator,
		bootstrap.InitAuth,
	}
	for _, initFunc := range initFunctions {
		go func(fn func()) {
			fn()
		}(initFunc)
	}

	// 运行引导程序
	bootstrap.Run()
}
