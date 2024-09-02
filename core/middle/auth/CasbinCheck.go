package auth

import (
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"vgo/core/log"
)

func CasbinCheckMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {
		sub := "alice" // 获取用户身份
		obj := c.Request.URL.Path
		act := c.Request.Method
		//if ok, _ := enforcer.Enforce(sub, obj, act); !ok {
		//	response.Forbidden(c, "无权限访问", nil)
		//	c.Abort()
		//	return
		//}
		log.GetLogger().Info("CasbinCheckMiddleware", zap.Any("sub", sub), zap.Any("obj", obj), zap.Any("act", act))
		c.Next()
	}
}
