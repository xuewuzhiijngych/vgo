package casbin

import (
	"fmt"
	"github.com/casbin/casbin/v2"
	"github.com/casbin/casbin/v2/model"
	gormadapter "github.com/casbin/gorm-adapter/v3"
	rediswatcher "github.com/casbin/redis-watcher/v2"
	rds "github.com/redis/go-redis/v9"
	"log"
	"vgo/internal/db"
	"vgo/internal/global"
)

// SetupCasbin 初始化Casbin
func SetupCasbin() *casbin.Enforcer {
	adapter, err := gormadapter.NewAdapterByDB(db.Con())
	if err != nil {
		panic(err)
	}
	rbacConfig := `
[request_definition]
r = sub, obj

[policy_definition]
p = sub, obj

[role_definition]
g = _, _

[policy_effect]
e = some(where (p.eft == allow))

[matchers]
m = g(r.sub, p.sub) && keyMatch2(r.obj, p.obj)
`
	m, err := model.NewModelFromString(rbacConfig)
	if err != nil {
		log.Fatalf("无法创建模型: %v", err)
	}
	enforcer, err := casbin.NewEnforcer(m, adapter)
	if err != nil {
		panic(err)
	}
	// Redis Watcher
	redisConf := global.App.Config.RedisConf
	addr := fmt.Sprintf("%v:%v", redisConf.Hostname, redisConf.HostPort)
	watcher, err := rediswatcher.NewWatcher(addr, rediswatcher.WatcherOptions{
		Channel: "/vgo-casbin", // 频道名称
		Options: rds.Options{
			Username: redisConf.UserName, // 用户名
			Password: redisConf.Password, // 密码
		},
	})
	err = enforcer.SetWatcher(watcher)
	// 策略发生变化时重新加载策略
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
