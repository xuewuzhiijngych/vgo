package middle

import (
	"github.com/gin-gonic/gin"
	"golang.org/x/time/rate"
	"net/http"
	"time"
)

func RateLimiter(maxRequests int, timeWindow time.Duration) gin.HandlerFunc {
	limiter := rate.NewLimiter(rate.Every(timeWindow/time.Duration(maxRequests)), maxRequests)
	return func(c *gin.Context) {
		if limiter.Allow() == false {
			c.JSON(http.StatusTooManyRequests, gin.H{"code": 429, "message": "请求频繁！"})
			c.Abort()
			return
		}
		c.Next()
	}
}
