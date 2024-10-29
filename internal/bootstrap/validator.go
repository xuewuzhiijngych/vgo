package bootstrap

import (
	"github.com/go-playground/validator/v10"
	"sync"
	"ych/vgo/internal/global"
)

// validatorLock 读写锁
var validatorLock sync.RWMutex

// InitValidator 初始化验证器
func InitValidator() {
	validatorLock.RLock()
	defer validatorLock.RUnlock()
	global.Validator = validator.New()
	if global.Validator == nil {
		panic("验证器初始化失败")
	}
}
