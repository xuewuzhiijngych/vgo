package configs

import (
	"fmt"
	"github.com/fsnotify/fsnotify"
	"github.com/spf13/viper"
	"path/filepath"
)

// App 应用配置
type App struct {
	Host        string `yaml:"host"`
	Port        string `yaml:"port"`
	CouNum      string `yaml:"cpu_num"`
	Version     string `yaml:"version"`
	Env         string `yaml:"env"`
	RequestLog  int    `yaml:"requestLog"`
	Lang        string `yaml:"lang"`
	CpuNum      string `yaml:"cpuNum"`
	ImgDomain   string `yaml:"imgDomain"`
	VideoDomain string `yaml:"videoDomain"`
	ApiOrigins  string `yaml:"apiOrigins"`
}

// DbConf 数据数据库配置
type DbConf struct {
	Driver   string `yaml:"driver"`
	Hostname string `yaml:"hostname"`
	HostPort string `yaml:"hostPort"`
	Username string `yaml:"username"`
	Password string `yaml:"password"`
	Database string `yaml:"database"`
}

// RedisConf Redis配置
type RedisConf struct {
	Hostname string `yaml:"hostname"`
	HostPort string `yaml:"hostPort"`
	UserName string `yaml:"username"`
	Password string `yaml:"password"`
	DB       int    `yaml:"db"`
}

// QueueConf Queue配置
type QueueConf struct {
	Enable      int    `yaml:"enable"`
	Hostname    string `yaml:"hostname"`
	HostPort    string `yaml:"hostPort"`
	UserName    string `yaml:"username"`
	Password    string `yaml:"password"`
	DB          int    `yaml:"db"`
	Concurrency int    `yaml:"concurrency"`
}

// JwtConf Jwt配置
type JwtConf struct {
	AdminKey         string `yaml:"adminKey"`
	AdminSingleLogin int    `yaml:"adminSingleLogin"`
	ApiKey           string `yaml:"apikey"`
	ApiSingleLogin   int    `yaml:"apiSingleLogin"`
	AdminTimeout     int64  `yaml:"adminTimeout"`
	ApiTimeout       int64  `yaml:"apiTimeout"`
}

// SnowflakeConf Snowflake配置
type SnowflakeConf struct {
	Node int64 `yaml:"node"`
}

type Config struct {
	DbConf        DbConf        `yaml:"dbConf"`
	RedisConf     RedisConf     `yaml:"redisConf"`
	QueueConf     QueueConf     `yaml:"queueConf"`
	JwtConf       JwtConf       `yaml:"jwtConf"`
	SnowflakeConf SnowflakeConf `yaml:"snowflakeConf"`
	App           App           `yaml:"api"`
}

func (config *Config) InitConfig() *Config {
	vp := viper.New()
	path, err := filepath.Abs("configs")
	if err != nil {
		panic(fmt.Sprintf("获取配置路径失败: %v", err))
	}
	vp.AddConfigPath(path)
	vp.SetConfigName("config")
	vp.SetConfigType("yaml")
	if err := vp.ReadInConfig(); err != nil {
		panic(err)
	}
	// 监听配置文件
	vp.WatchConfig()
	vp.OnConfigChange(func(in fsnotify.Event) {
		fmt.Println("检测到配置文件变化:", in.Name)
		if err := vp.Unmarshal(&config); err != nil { // 重载配置
			fmt.Println(err)
		}
	})
	err = vp.Unmarshal(&config)
	if err != nil {
		panic(err)
	}
	return config

}
