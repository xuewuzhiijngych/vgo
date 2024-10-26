package global

import (
	"github.com/gin-gonic/gin"
	goRedis "github.com/redis/go-redis/v9"
	"go.uber.org/zap"
	"gorm.io/gorm"
	"ych/vgo/internal/config"
)

// Configs 全局配置
type Configs struct {
	App       config.App       `yaml:"app"`
	DbConf    config.DbConf    `yaml:"dbConf"`
	RedisConf config.RedisConf `yaml:"redisConf"`
	JwtConf   config.JwtConf   `yaml:"jwtConf"`
}

// Config 全局配置
var Config Configs

// DbCon 数据库连接
var DbCon *gorm.DB

// RedisCon redis连接
var RedisCon *goRedis.Client

// Logger 日志
var Logger *zap.Logger

// Engine 全局引擎
var Engine *gin.Engine
