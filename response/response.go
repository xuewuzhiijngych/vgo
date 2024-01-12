package response

import (
	"github.com/gin-gonic/gin"
	"net/http"
	"time"
)

func Success(ctx *gin.Context, msg string, data interface{}) {
	ctx.JSON(http.StatusOK, gin.H{
		"code":    1,
		"message": msg,
		"data":    data,
		"time":    time.Now().Unix(),
	})
}
