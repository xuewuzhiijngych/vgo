package app

import (
	"fmt"
	"github.com/gin-gonic/gin"
	job "ych/vgo/app/jobs"
	"ych/vgo/internal/global"
	"ych/vgo/internal/pkg/queue"
)

func Test(ctx *gin.Context) {
	//ctx.JSON(http.StatusOK, gin.H{
	//	"code": http.StatusInternalServerError,
	//	"aa":   trans.Trans(ctx, "Token无效"),
	//})
	//global.Logger.Info("Request handled", zap.Any("data", "test"))
	//global.RedisCon.Set(ctx, "test", "test", 0)

	//response.Success(ctx, "哈哈哈", gin.H{
	//	"test": snow.SnowflakeService().Generate(),
	//})

	//// 生成token
	//res, err := auth.GenAdminToken(ctx, 1, []string{"哈哈"}, 1)
	//if err != nil {
	//	response.Fail(ctx, "失败", nil)
	//	return
	//}
	//response.Success(ctx, "登录成功", res)

	client := queue.NewRedisClient()
	defer queue.CloseRedisClient(client)
	task, err := job.NewTestJob(42, "666666")
	if err != nil {
		global.Logger.Error(fmt.Sprintf("could not create task: %v", err))
	}
	info, err := client.Enqueue(task)
	if err != nil {
		global.Logger.Error(fmt.Sprintf("could not enqueue task: %v", err))
	}
	global.Logger.Info(fmt.Sprintf("enqueued task: id=%s queue=%s", info.ID, info.Queue))
}
