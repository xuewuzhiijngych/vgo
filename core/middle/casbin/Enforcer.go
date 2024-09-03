package casbin

import (
	"fmt"
	"github.com/casbin/casbin/v2"
	gormadapter "github.com/casbin/gorm-adapter/v3"
	rediswatcher "github.com/casbin/redis-watcher/v2"
	rds "github.com/redis/go-redis/v9"
	"os"
	"vgo/core/db"
	"vgo/core/global"
)

// SetupCasbin 初始化Casbin
func SetupCasbin() *casbin.Enforcer {
	adapter, err := gormadapter.NewAdapterByDB(db.Con())
	if err != nil {
		panic(err)
	}
	path, err := os.Getwd()
	if err != nil {
		panic(err)
	}
	enforcer, err := casbin.NewEnforcer(path+"/rbac.conf", adapter)
	if err != nil {
		panic(err)
	}

	// 初始化Redis Watcher
	redisConf := global.App.Config.RedisConf
	addr := fmt.Sprintf("%v:%v", redisConf.Hostname, redisConf.HostPort)
	watcher, err := rediswatcher.NewWatcher(addr, rediswatcher.WatcherOptions{
		Channel: "/vgo-casbin", // 频道名称
		Options: rds.Options{
			Username: redisConf.UserName, // 用户名
			Password: redisConf.Password, // 密码
		},
	})

	// 设置Watcher
	err = enforcer.SetWatcher(watcher)

	// 设置回调函数，当策略发生变化时重新加载策略
	err = watcher.SetUpdateCallback(func(string) {
		err = enforcer.LoadPolicy()
	})

	// 加载策略
	err = enforcer.LoadPolicy()
	if err != nil {
		panic(err)
	}
	return enforcer
}
