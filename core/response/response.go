package response

import (
	"github.com/gin-gonic/gin"
	"net/http"
	"time"
)

func Success(ctx *gin.Context, msg string, data interface{}, extraData ...interface{}) {
	ctx.JSON(http.StatusOK, gin.H{
		"code":    http.StatusOK,
		"msg":     msg,
		"data":    data,
		"ext":     extraData,
		"time":    time.Now().Unix(),
		"success": true,
	})
}

func Fail(ctx *gin.Context, msg string, data interface{}, extraData ...interface{}) {
	ctx.JSON(http.StatusOK, gin.H{
		"code":    http.StatusInternalServerError,
		"msg":     msg,
		"data":    data,
		"ext":     extraData,
		"time":    time.Now().Unix(),
		"success": false,
	})
}

func NotLogin(ctx *gin.Context, msg string, data interface{}, extraData ...interface{}) {
	ctx.JSON(http.StatusOK, gin.H{
		"code":    http.StatusUnauthorized,
		"msg":     msg,
		"data":    data,
		"ext":     extraData,
		"time":    time.Now().Unix(),
		"success": false,
	})
}
