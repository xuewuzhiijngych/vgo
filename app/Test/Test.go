package Test

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"github.com/hibiken/asynq"
	"vgo/core/global"
	"vgo/core/log"
	"vgo/tasks"
)

func Index(ctx *gin.Context) {
	//res := time.Duration(global.App.Config.JwtConf.Timeout)
	//response.Success(ctx, "成功", map[string]interface{}{}, res)

	//query := db.GetCon().Model(&Product.Product{}).Find(&Product.Product{})
	//response.Success(ctx, "查询成功", query, nil)

	//err := db.Con().AutoMigrate(&Role.RoleMenu{})
	//if err != nil {
	//	return
	//}

	redisConf := global.App.Config.RedisConf
	redisAddr := fmt.Sprintf("%v:%v", redisConf.Hostname, redisConf.HostPort)
	client := asynq.NewClient(asynq.RedisClientOpt{
		Addr:     redisAddr,
		Username: redisConf.UserName,
		Password: redisConf.Password,
	})
	defer client.Close()

	// ------------------------------------------------------
	// Example 1: Enqueue task to be processed immediately.
	//            Use (*Client).Enqueue method.
	// ------------------------------------------------------

	task, err := tasks.NewTestDelivery(42, "some:template:id")
	if err != nil {
		log.GetLogger().Error(fmt.Sprintf("could not create task: %v", err))
	}
	info, err := client.Enqueue(task)
	if err != nil {
		log.GetLogger().Error(fmt.Sprintf("could not enqueue task: %v", err))
	}
	log.GetLogger().Info(fmt.Sprintf("enqueued task: id=%s queue=%s", info.ID, info.Queue))
}
