package auth

import (
	"github.com/gin-gonic/gin"
	"strings"
	"vgo/core/redis"
	"vgo/core/response"
)

// AdminAuthMiddleware 后台管理用户的JWT验证中间件
func AdminAuthMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {
		authHeader := c.GetHeader("Authorization")
		parts := strings.SplitN(authHeader, " ", 2)
		if !(len(parts) == 2 && parts[0] == "Bearer") {
			response.NotLogin(c, "Token is invalid --Bapi-- Header format is invalid", nil)
			c.Abort()
			return
		}
		tokenString := parts[1]
		if tokenString == "" {
			response.NotLogin(c, "Token is invalid --Bapi-- Header is missing", nil)
			c.Abort()
			return
		}
		claims, err := ParseAdminToken(tokenString)
		if err != nil {
			response.NotLogin(c, "Token is invalid --Bapi-- 解析Fail", nil)
			c.Abort()
			return
		}

		if AssertIsTokenInvalid(c, tokenString) {
			response.NotLogin(c, "Token is invalid --Bapi-- 黑名单", nil)
			c.Abort()
			return
		}

		//// redis内读取token----单个token有效时使用
		//redisToken := redis.Con().Get(c,"admin_token" + claims.UserID)
		//if redisToken == nil || redisToken.Val() != tokenString {
		//response.NotLogin(c, "Token is invalid --Bapi-- redis00", nil)
		//	c.Abort()
		//	return
		//}

		// redis内读取token----多个token有效时使用
		redisToken := redis.Con().LRange(c, "admin_token"+claims.UserID, 0, -1)
		if redisToken == nil || len(redisToken.Val()) == 0 {
			response.NotLogin(c, "Token is invalid --Bapi-- redis01", nil)
			c.Abort()
			return
		}
		// 判断tokenString是否在redisToken中----多个token有效时使用
		if !strings.Contains(strings.Join(redisToken.Val(), ""), tokenString) {
			response.NotLogin(c, "Token is invalid --Bapi-- redis02", nil)
			c.Abort()
			return
		}
		c.Set("userID", claims.UserID)
		c.Set("role", claims.Role)
		c.Set("super", claims.Super)
		c.Next()
	}
}

// UserAuthMiddleware 前台用户的JWT验证中间件
func UserAuthMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {
		authHeader := c.GetHeader("Authorization")
		parts := strings.SplitN(authHeader, " ", 2)
		if !(len(parts) == 2 && parts[0] == "Bearer") {
			response.NotLogin(c, "Token is invalid --api-- Header format is invalid", nil)
			c.Abort()
			return
		}
		tokenString := parts[1]
		if tokenString == "" {
			response.NotLogin(c, "Token is invalid --api-- Header is missing", nil)
			c.Abort()
			return
		}

		claims, err := ParseUserToken(tokenString)
		if err != nil {
			response.NotLogin(c, "Token is invalid --api-- 解析Fail", nil)
			c.Abort()
			return
		}

		if AssertApiTokenIsInvalid(c, tokenString) {
			response.NotLogin(c, "Token is invalid --api-- 黑名单", nil)
			c.Abort()
			return
		}

		// redis内读取token----单个token有效时使用
		redisToken := redis.Con().Get(c, "api_token"+claims.UserID)
		if redisToken == nil || redisToken.Val() != tokenString {
			response.NotLogin(c, "Token is invalid --api-- redis00", nil)
			c.Abort()
			return
		}
		//// redis内读取token----多个token有效时使用
		//redisToken := redis.Con().LRange(c,"api_token"+claims.UserID, 0, -1)
		//if redisToken == nil || len(redisToken.Val()) == 0 {
		//response.NotLogin(c, "Token is invalid --api-- redis01", nil)
		//	c.Abort()
		//	return
		//}
		//// 判断tokenString是否在redisToken中----多个token有效时使用
		//if !strings.Contains(strings.Join(redisToken.Val(), ""), tokenString) {
		//  response.NotLogin(c, "Token is invalid --api-- redis02", nil)
		//	c.Abort()
		//	return
		//}

		c.Set("userID", claims.UserID)
		c.Next()
	}
}
