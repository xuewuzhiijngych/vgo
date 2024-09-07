package cors

import (
	"github.com/gin-gonic/gin"
	"strings"
	"vgo/core/global"
	"vgo/core/response"
)

// ApiCors Api处理跨域请求
func ApiCors() gin.HandlerFunc {
	return func(c *gin.Context) {
		origins := global.App.Config.ApiConf.ApiOrigins
		allowedOrigins := strings.Split(origins, ",")
		origin := c.Request.Header.Get("Origin")
		for _, allowedOrigin := range allowedOrigins {
			if origin == allowedOrigin {
				c.Writer.Header().Set("Access-Control-Allow-Origin", origin)
				c.Writer.Header().Set("Access-Control-Allow-Credentials", "true")
				c.Writer.Header().Set("Access-Control-Allow-Headers", "Content-Type, Content-Length, Accept-Encoding, X-CSRF-Token, Authorization, accept, origin, Cache-Control, X-Requested-With")
				c.Writer.Header().Set("Access-Control-Allow-Methods", "POST, OPTIONS, GET, PUT, DELETE")
				break
			}
		}
		if c.Request.Method == "OPTIONS" {
			response.Fail(c, "不支持!", nil)
			c.Abort()
			return
		}
		c.Next()
	}
}
