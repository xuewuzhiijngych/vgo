package auth

import (
	"github.com/casbin/casbin/v2"
	"github.com/gin-gonic/gin"
	"vgo/core/response"
)

func AuthMiddleware(enforcer *casbin.Enforcer) gin.HandlerFunc {
	return func(c *gin.Context) {
		sub := "alice" // 获取用户身份
		obj := c.Request.URL.Path
		act := c.Request.Method
		if ok, _ := enforcer.Enforce(sub, obj, act); !ok {
			response.Forbidden(c, "无权限访问", nil)
			c.Abort()
			return
		}
		c.Next()
	}
}
