package response

import (
	"github.com/gin-gonic/gin"
	"net/http"
	"time"
)

func Success(ctx *gin.Context, msg string, data interface{}, extraData interface{}) {
	ctx.JSON(http.StatusOK, gin.H{
		"code":       1,
		"message":    msg,
		"data":       data,
		"extra_data": extraData,
		"time":       time.Now().Unix(),
	})
}

func Fail(ctx *gin.Context, msg string, data interface{}, extraData interface{}) {
	ctx.JSON(http.StatusOK, gin.H{
		"code":       0,
		"message":    msg,
		"data":       data,
		"extra_data": extraData,
		"time":       time.Now().Unix(),
	})
}
