package bootstrap

import (
	"sync"
	"time"
	"ych/vgo/internal/global"
	"ych/vgo/internal/pkg/middleware/auth"
)

// authLock 读写锁
var authLock sync.RWMutex

// InitAuth 初始化验证器
func InitAuth() {
	authLock.RLock()
	defer authLock.RUnlock()
	jwtConf := global.Config.JwtConf
	auth.AdminTokenExpireDuration = time.Duration(jwtConf.AdminTimeout) * time.Hour
	auth.ApiTokenExpireDuration = time.Duration(jwtConf.ApiTimeout) * time.Hour
	auth.AdminSecret = []byte(jwtConf.AdminKey)
	auth.ApiSecret = []byte(jwtConf.ApiKey)
}
