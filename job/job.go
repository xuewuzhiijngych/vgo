package job

import (
	"github.com/hibiken/asynq"
)

// JobMaps 任务处理器映射
var JobMaps = map[string]asynq.HandlerFunc{
	TestJob: HandleTestJobTask,
	// 添加其他任务处理对儿
	// "...": ...,
}
