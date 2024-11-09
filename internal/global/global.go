package global

import (
	"github.com/casbin/casbin/v2"
	"github.com/gin-gonic/gin"
	"github.com/go-playground/validator/v10"
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
	OssConf       config.OssConf       `yaml:"ossConf"`
	CosConf       config.CosConf       `yaml:"cosConf"`
}

// Config 全局配置
var Config Configs

// DbCon 数据库连接
var DbCon *gorm.DB

// RedisCon redis连接
var RedisCon *goRedis.Client

// Logger 日志
var Logger *zap.Logger

// BackendRouter 后台路由
var BackendRouter *gin.RouterGroup

// ApiRouter 接口路由
var ApiRouter *gin.RouterGroup

// Validator 验证器
var Validator *validator.Validate

// Rbac 权限管理
var Rbac *casbin.Enforcer

// Engine 全局引擎
var Engine *gin.Engine
