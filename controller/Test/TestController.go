package Test

import (
	"github.com/gin-gonic/gin"
	"time"
	"vgo/core/global"
	"vgo/core/response"
)

func Index(ctx *gin.Context) {

	res := time.Duration(global.App.Config.JwtConf.Timeout)

	response.Success(ctx, "成功", map[string]interface{}{}, res)
}
