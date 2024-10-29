package response

import (
	"github.com/gin-gonic/gin"
	"net/http"
	"time"
	"ych/vgo/internal/trans"
)

func jsonResponse(ctx *gin.Context, code int, msg string, data interface{}, extraData ...interface{}) {
	ctx.JSON(code, gin.H{
		"code":    code,
		"msg":     trans.Trans(ctx, msg),
		"data":    data,
		"ext":     extraData,
		"time":    time.Now().Unix(),
		"success": code < 400,
	})
}

func Success(ctx *gin.Context, msg string, data interface{}, extraData ...interface{}) {
	jsonResponse(ctx, http.StatusOK, msg, data, extraData...)
}

func Fail(ctx *gin.Context, msg string, data interface{}, extraData ...interface{}) {
	jsonResponse(ctx, http.StatusInternalServerError, msg, data, extraData...)
}

func NotLogin(ctx *gin.Context, msg string, data interface{}, extraData ...interface{}) {
	jsonResponse(ctx, http.StatusUnauthorized, msg, data, extraData...)
}

func Forbidden(ctx *gin.Context, msg string, data interface{}, extraData ...interface{}) {
	jsonResponse(ctx, http.StatusForbidden, msg, data, extraData...)
}

func TooManyRequests(ctx *gin.Context, msg string, data interface{}, extraData ...interface{}) {
	jsonResponse(ctx, http.StatusTooManyRequests, msg, data, extraData...)
}
