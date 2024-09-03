package queue

import (
	"fmt"
	"github.com/hibiken/asynq"
	"vgo/core/global"
	"vgo/tasks"
)

// InitQueue 初始化队列
func InitQueue() {
	redisConf := global.App.Config.RedisConf
	redisAddr := fmt.Sprintf("%v:%v", redisConf.Hostname, redisConf.HostPort)
	srv := asynq.NewServer(
		asynq.RedisClientOpt{
			Addr:     redisAddr,
			Username: redisConf.UserName,
			Password: redisConf.Password,
		},
		asynq.Config{
			Concurrency: 10,
			Queues: map[string]int{
				"critical": 6,
				"default":  3,
				"low":      1,
			},
		},
	)
	mux := asynq.NewServeMux()
	mux.HandleFunc(tasks.TestDelivery, tasks.HandleTestDeliveryTask)
	if err := srv.Run(mux); err != nil {
		fmt.Println("Failed to start server:", err)
	}
}

// NewRedisClient 创建一个新的 asynq.Client 并返回
func NewRedisClient() (*asynq.Client, error) {
	redisConf := global.App.Config.RedisConf
	redisAddr := fmt.Sprintf("%v:%v", redisConf.Hostname, redisConf.HostPort)
	client := asynq.NewClient(asynq.RedisClientOpt{
		Addr:     redisAddr,
		Username: redisConf.UserName,
		Password: redisConf.Password,
	})
	return client, nil
}

// CloseRedisClient 关闭 asynq.Client
func CloseRedisClient(client *asynq.Client) {
	if err := client.Close(); err != nil {
		fmt.Println("Failed to close client:", err)
	}
}
