package redis

import (
	"fmt"
	"github.com/go-redis/redis"
	"vgo/core/global"
)

var goredis *redis.Client

func MyInit() {
	redisConf := global.App.Config.RedisConf
	addr := fmt.Sprintf("%v:%v", redisConf.Hostname, redisConf.HostPort)
	d := redis.NewClient(&redis.Options{
		Addr:     addr,
		Password: redisConf.Password,
		DB:       redisConf.DB,
	})
	goredis = d
}

// GetCon 获取redis连接
func GetCon() *redis.Client {
	return goredis
}
