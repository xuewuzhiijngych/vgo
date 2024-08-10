package redis

import (
	"fmt"
	goRedis "github.com/go-redis/redis"
	"vgo/core/global"
)

var redis *goRedis.Client

func InitCon() {
	redisConf := global.App.Config.RedisConf
	addr := fmt.Sprintf("%v:%v", redisConf.Hostname, redisConf.HostPort)
	d := goRedis.NewClient(&goRedis.Options{
		Addr:     addr,
		Password: redisConf.Password,
		DB:       redisConf.DB,
	})
	redis = d
}

// Con 获取redis连接
func Con() *goRedis.Client {
	return redis
}
