package app

import (
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"net/http"
	"ych/vgo/internal/global"
)

func Test(ctx *gin.Context) {
	ctx.JSON(http.StatusOK, gin.H{
		"code": http.StatusInternalServerError,
		"aa":   "bb",
	})
	global.Logger.Info("Request handled", zap.Any("data", "test"))
	global.RedisCon.Set(ctx, "test", "test", 0)
}
