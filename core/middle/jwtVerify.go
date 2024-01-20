package middle

import (
	jwt "github.com/appleboy/gin-jwt/v2"
	"github.com/gin-gonic/gin"
	"time"
	"vgo/controller"
	"vgo/core/global"
	"vgo/core/response"
)

var (
	AuthMiddleware, _ = jwt.New(&jwt.GinJWTMiddleware{
		Key:             []byte(global.App.Config.JwtConf.Key),
		Timeout:         time.Hour,
		MaxRefresh:      time.Hour,
		IdentityKey:     "id",
		PayloadFunc:     payloadFunc,
		IdentityHandler: identityHandler,
		Authenticator:   controller.Authenticator,
		Authorizator:    authorizator,
		Unauthorized:    unauthorized,
		TokenLookup:     "header: Authorization",
		TokenHeadName:   "Bearer",
		TimeFunc:        time.Now,
	})
)

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
	//fmt.Println(data)
	return true
}

// 未授权处理逻辑
func unauthorized(c *gin.Context, code int, message string) {
	response.Fail(c, "未登录", map[string]interface{}{
		"HttpCode": code,
		"HttpMsg":  message,
	}, nil)
}
