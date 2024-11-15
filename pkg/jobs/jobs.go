package job

import (
	"github.com/hibiken/asynq"
)

// DefineJobMaps 任务处理器映射
var DefineJobMaps = map[string]asynq.HandlerFunc{
	TestJob: HandleTestJobTask,
	// 添加其他任务处理对儿
	// "...": ...,
}
