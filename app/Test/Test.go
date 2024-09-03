package Test

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"github.com/hibiken/asynq"
	"time"
	"vgo/core/log"
	"vgo/core/queue"
	"vgo/tasks"
)

func Index(ctx *gin.Context) {
	//err := db.Con().AutoMigrate(&Role.RoleMenu{})
	//if err != nil {
	//	return
	//}
	//redisConf := global.App.Config.RedisConf
	//redisAddr := fmt.Sprintf("%v:%v", redisConf.Hostname, redisConf.HostPort)
	//client := asynq.NewClient(asynq.RedisClientOpt{
	//	Addr:     redisAddr,
	//	Username: redisConf.UserName,
	//	Password: redisConf.Password,
	//})
	//defer func(client *asynq.Client) {
	//	err := client.Close()
	//	if err != nil {
	//		fmt.Println(err)
	//	}
	//}(client)
	client, err := queue.NewRedisClient()
	if err != nil {
		fmt.Println("Failed to create redis client:", err)
		return
	}
	defer queue.CloseRedisClient(client)
	task, err := tasks.NewTestDelivery(42, "some:template:id")
	if err != nil {
		log.GetLogger().Error(fmt.Sprintf("could not create task: %v", err))
	}
	info, err := client.Enqueue(task, asynq.ProcessIn(3*time.Second))
	if err != nil {
		log.GetLogger().Error(fmt.Sprintf("could not enqueue task: %v", err))
	}
	log.GetLogger().Info(fmt.Sprintf("enqueued task: id=%s queue=%s", info.ID, info.Queue))
}
