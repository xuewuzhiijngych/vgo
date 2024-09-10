package cors

import (
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"strings"
	"vgo/core/global"
	"vgo/core/log"
)

// BapiCors Bapi处理跨域请求
func BapiCors() gin.HandlerFunc {
	return func(c *gin.Context) {
		origins := global.App.Config.ApiConf.BapiOrigins
		allowedOrigins := strings.Split(origins, ",")
		log.GetLogger().Info("allowedOrigins: ", zap.Any("allowedOrigins", allowedOrigins))
		origin := c.Request.Header.Get("Origin")
		log.GetLogger().Info("userOrigins: ", zap.Any("userOrigins", origin))
		for _, allowedOrigin := range allowedOrigins {
			if origin == allowedOrigin {
				c.Writer.Header().Set("Access-Control-Allow-Origin", origin)
				c.Writer.Header().Set("Access-Control-Allow-Credentials", "true")
				c.Writer.Header().Set("Access-Control-Allow-Headers", "Content-Type, Content-Length, Accept-Encoding, X-CSRF-Token, Authorization, accept, origin, Cache-Control, X-Requested-With")
				c.Writer.Header().Set("Access-Control-Allow-Methods", "POST, OPTIONS, GET, PUT, DELETE")
				break
			}
		}
		c.Next()
	}
}
