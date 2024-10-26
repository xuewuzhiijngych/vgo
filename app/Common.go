package app

import (
	"github.com/gin-gonic/gin"
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
		"test": "ok",
	})
}
