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
	App           config.App           `yaml:"app"`
	DbConf        config.DbConf        `yaml:"dbConf"`
	RedisConf     config.RedisConf     `yaml:"redisConf"`
	QueueConf     config.QueueConf     `yaml:"queueConf"`
	JwtConf       config.JwtConf       `yaml:"jwtConf"`
	SnowflakeConf config.SnowflakeConf `yaml:"snowflakeConf"`
}

// Config 全局配置
var Config Configs

// DbCon 数据库连接
var DbCon *gorm.DB

// RedisCon redis连接
var RedisCon *goRedis.Client

// Logger 日志
var Logger *zap.Logger

// Routers 全局路由
type Routers struct{}

// Engine 全局引擎
var Engine *gin.Engine
