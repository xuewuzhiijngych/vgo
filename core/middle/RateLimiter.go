package middle

import (
	"github.com/gin-gonic/gin"
	"golang.org/x/time/rate"
	"time"
	"vgo/core/response"
)

// RateLimiter 限流中间件
func RateLimiter(maxRequests int, timeWindow time.Duration) gin.HandlerFunc {
	limiter := rate.NewLimiter(rate.Every(timeWindow/time.Duration(maxRequests)), maxRequests)
	return func(c *gin.Context) {
		if limiter.Allow() == false {
			response.TooManyRequests(c, "请求频繁!", nil)
			c.Abort()
			return
		}
		c.Next()
	}
}
