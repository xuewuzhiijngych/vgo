package middle

import (
	jwt "github.com/appleboy/gin-jwt/v2"
	"github.com/gin-gonic/gin"
	"time"
)

var (
	key               = []byte("pDxCHgMzlarDuWFeDVSlQNHyZVoxeBfJsGVz")
	AuthMiddleware, _ = jwt.New(&jwt.GinJWTMiddleware{
		Key:             key,
		Timeout:         time.Hour,
		MaxRefresh:      time.Hour,
		IdentityKey:     "id",
		PayloadFunc:     payloadFunc,
		IdentityHandler: identityHandler,
		Authenticator:   authenticator,
		Authorizator:    authorizator,
		Unauthorized:    unauthorized,
		TokenLookup:     "header: Authorization",
		TokenHeadName:   "Bearer",
		TimeFunc:        time.Now,
	})
)

// 用户身份验证逻辑
func authenticator(c *gin.Context) (interface{}, error) {
	username := c.PostForm("username")
	password := c.PostForm("password")
	if isValidUser(username, password) {
		return "user_id", nil
	}
	return nil, jwt.ErrFailedAuthentication
}

// 账号密码验证逻辑
func isValidUser(username, password string) bool {
	return username == "11" && password == "11"
}

// 用户身份处理逻辑
func identityHandler(c *gin.Context) interface{} {
	claims := jwt.ExtractClaims(c)
	return claims["id"].(string)
}

// JWT 负载生成逻辑
func payloadFunc(data interface{}) jwt.MapClaims {
	if v, ok := data.(string); ok {
		return jwt.MapClaims{
			"id": v,
		}
	}
	return jwt.MapClaims{}
}

// 用户权限验证逻辑
func authorizator(data interface{}, c *gin.Context) bool {
	// 在此处执行您的授权逻辑，例如检查用户是否具有特定权限
	return true
}

// 未授权处理逻辑
func unauthorized(c *gin.Context, code int, message string) {
	c.JSON(code, gin.H{
		"code":    code,
		"message": "未授权！",
	})
}