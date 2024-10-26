package database

import (
	"context"
	"fmt"
	goRedis "github.com/redis/go-redis/v9"
	"ych/vgo/internal/global"
)

// ConnectRedis 连接redis
func ConnectRedis() *goRedis.Client {
	redisConf := global.Config.RedisConf
	addr := fmt.Sprintf("%v:%v", redisConf.Hostname, redisConf.HostPort)
	client := goRedis.NewClient(&goRedis.Options{
		Addr:     addr,
		Username: redisConf.UserName,
		Password: redisConf.Password,
		DB:       redisConf.DB,
	})
	// 测试连接是否成功
	if err := client.Ping(context.Background()).Err(); err != nil {
		fmt.Printf("Redis连接错误: %v\n", err)
		return nil
	}
	return client
}
