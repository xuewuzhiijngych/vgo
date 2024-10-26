package app

import (
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"net/http"
	"ych/vgo/internal/global"
	"ych/vgo/internal/trans"
)

func Test(ctx *gin.Context) {
	ctx.JSON(http.StatusOK, gin.H{
		"code": http.StatusInternalServerError,
		"aa":   trans.Trans(ctx, "Token无效"),
	})
	global.Logger.Info("Request handled", zap.Any("data", "test"))
	global.RedisCon.Set(ctx, "test", "test", 0)
}
