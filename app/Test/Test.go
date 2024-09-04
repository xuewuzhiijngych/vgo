package Test

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"github.com/hibiken/asynq"
	"time"
	"vgo/core/log"
	"vgo/core/queue"
	"vgo/job"
)

func Index(ctx *gin.Context) {
	//err := db.Con().AutoMigrate(&Role.RoleMenu{})
	//if err != nil {
	//	return
	//}
	client, err := queue.NewRedisClient()
	if err != nil {
		fmt.Println("Failed to create redis client:", err)
		return
	}
	defer queue.CloseRedisClient(client)
	task, err := job.NewTestJob(42, "666666")
	if err != nil {
		log.GetLogger().Error(fmt.Sprintf("could not create task: %v", err))
	}
	info, err := client.Enqueue(task, asynq.ProcessIn(time.Second*3))
	if err != nil {
		log.GetLogger().Error(fmt.Sprintf("could not enqueue task: %v", err))
	}
	log.GetLogger().Info(fmt.Sprintf("enqueued task: id=%s queue=%s", info.ID, info.Queue))
}
