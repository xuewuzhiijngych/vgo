package bootstrap

import (
	"sync"
	"ych/vgo/internal/database"
	"ych/vgo/internal/global"
)

// redisLock 读写锁
var redisLock sync.RWMutex

// InitRedis 初始化redis连接
func InitRedis() {
	redisLock.RLock()
	defer redisLock.RUnlock()
	global.RedisCon = database.ConnectRedis()
	if global.RedisCon == nil {
		panic("redis连接失败")
	}
}
