package app

import (
	"github.com/gin-gonic/gin"
	"ych/vgo/internal/pkg/snow"
	"ych/vgo/pkg/response"
)

func Test(ctx *gin.Context) {
	//ctx.JSON(http.StatusOK, gin.H{
	//	"code": http.StatusInternalServerError,
	//	"aa":   trans.Trans(ctx, "Token无效"),
	//})
	//global.Logger.Info("Request handled", zap.Any("data", "test"))
	//global.RedisCon.Set(ctx, "test", "test", 0)

	response.Success(ctx, "哈哈哈", gin.H{
		"test": snow.SnowflakeService().Generate(),
	})

	//// 生成token
	//res, err := auth.GenAdminToken(ctx, 1, []string{"哈哈"}, 1)
	//if err != nil {
	//	response.Fail(ctx, "失败", nil)
	//	return
	//}
	//response.Success(ctx, "登录成功", res)
}
