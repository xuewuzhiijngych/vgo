package casbin

import (
	"github.com/casbin/casbin/v2"
	"github.com/gin-gonic/gin"
	"vgo/core/response"
)

func CheckMiddleware(e *casbin.Enforcer) gin.HandlerFunc {
	return func(c *gin.Context) {
		super := c.GetInt("super") // 超级管理员
		if super == 1 {
			c.Next()
			return
		}
		sub := c.GetStringSlice("role") // 获取角色
		obj := c.Request.URL.Path
		for _, v := range sub {
			if ok, _ := e.Enforce(v, obj); ok {
				c.Next()
				return
			}
		}
		response.Forbidden(c, "无权限访问", nil)
		c.Abort()
	}
}
