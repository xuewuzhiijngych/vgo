package queue

import (
	"fmt"
	"github.com/hibiken/asynq"
	"ych/vgo/internal/global"
	"ych/vgo/pkg/jobs"
)

// InitQueue 初始化队列
func InitQueue() {
	queueConf := global.Config.QueueConf
	redisAddr := fmt.Sprintf("%v:%v", queueConf.Hostname, queueConf.HostPort)
	srv := asynq.NewServer(
		asynq.RedisClientOpt{
			Addr:     redisAddr,
			Username: queueConf.UserName,
			Password: queueConf.Password,
			DB:       queueConf.DB,
		},
		asynq.Config{
			Concurrency: queueConf.Concurrency,
			Queues: map[string]int{
				"critical": 6,
				"default":  3,
				"low":      1,
			},
		},
	)
	mux := asynq.NewServeMux()
	SetupJobHandlers(mux)
	if err := srv.Run(mux); err != nil {
		fmt.Println("Failed to start server:", err)
	}
}

// SetupJobHandlers 注册任务处理器
func SetupJobHandlers(mux *asynq.ServeMux) {
	for jobName, handler := range job.DefineJobMaps {
		mux.HandleFunc(jobName, handler)
	}
}

// NewRedisClient 创建一个新的 asynq.Client 并返回
func NewRedisClient() *asynq.Client {
	queueConf := global.Config.QueueConf
	redisAddr := fmt.Sprintf("%v:%v", queueConf.Hostname, queueConf.HostPort)
	client := asynq.NewClient(asynq.RedisClientOpt{
		Addr:     redisAddr,
		Username: queueConf.UserName,
		Password: queueConf.Password,
		DB:       queueConf.DB,
	})
	return client
}

// CloseRedisClient 关闭 asynq.Client
func CloseRedisClient(client *asynq.Client) {
	if err := client.Close(); err != nil {
		fmt.Println("Failed to close client:", err)
	}
}
