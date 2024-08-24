package auth

import (
	"github.com/gin-gonic/gin"
	"net/http"
	"strings"
	"vgo/core/redis"
)

// AdminAuthMiddleware 后台管理用户的JWT验证中间件
func AdminAuthMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {
		authHeader := c.GetHeader("Authorization")
		parts := strings.SplitN(authHeader, " ", 2)
		if !(len(parts) == 2 && parts[0] == "Bearer") {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Authorization header format is invalid"})
			c.Abort()
			return
		}
		tokenString := parts[1]
		if tokenString == "" {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Authorization header is missing"})
			c.Abort()
			return
		}
		claims, err := ParseAdminToken(tokenString)
		if err != nil {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid token"})
			c.Abort()
			return
		}

		if AssertIsTokenInvalid(tokenString) {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "在黑名单"})
			c.Abort()
			return
		}

		redisToken := redis.Con().Get("admin_token" + claims.UserID)
		if redisToken == nil || redisToken.Val() != tokenString {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Token is invalid -- redis"})
			c.Abort()
			return
		}

		c.Set("userID", claims.UserID)
		c.Set("role", claims.Role)
		c.Next()
	}
}

// UserAuthMiddleware 前台用户的JWT验证中间件
func UserAuthMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {
		authHeader := c.GetHeader("Authorization")
		parts := strings.SplitN(authHeader, " ", 2)
		if !(len(parts) == 2 && parts[0] == "Bearer") {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Authorization header format is invalid"})
			c.Abort()
			return
		}
		tokenString := parts[1]
		if tokenString == "" {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Authorization header is missing"})
			c.Abort()
			return
		}

		claims, err := ParseUserToken(tokenString)
		if err != nil {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid token"})
			c.Abort()
			return
		}

		if AssertApiTokenIsInvalid(tokenString) {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "在黑名单-api"})
			c.Abort()
			return
		}

		redisToken := redis.Con().Get("api_token" + claims.UserID)
		if redisToken == nil || redisToken.Val() != tokenString {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Token is invalid --api-- redis"})
			c.Abort()
			return
		}

		c.Set("userID", claims.UserID)
		c.Next()
	}
}
