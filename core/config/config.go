package config

import (
	"fmt"
	"github.com/fsnotify/fsnotify"
	"github.com/spf13/viper"
	"os"
)

// App 应用配置
type App struct {
	Domain     string `yaml:"domain"`
	Port       string `yaml:"port"`
	CouNum     string `yaml:"cpu_num"`
	Version    string `yaml:"version"`
	Env        string `yaml:"env"`
	RequestLog int    `yaml:"requestlog"`
}

// DbConf 数据数据库配置
type DbConf struct {
	Driver   string `yaml:"driver"`
	Hostname string `yaml:"hostname"`
	HostPort string `yaml:"hostport"`
	Username string `yaml:"username"`
	Password string `yaml:"password"`
	Database string `yaml:"database"`
	Prefix   string `yaml:"prefix"`
}

// RedisConf Redis配置
type RedisConf struct {
	Hostname string `yaml:"hostname"`
	HostPort string `yaml:"hostport"`
	Password string `yaml:"password"`
	DB       int    `yaml:"db"`
}

type Config struct {
	DbConf    DbConf    `yaml:"dbconf"`
	RedisConf RedisConf `yaml:"redisconf"`
	App       App       `yaml:"app"`
}

func (config *Config) InitConfig() *Config {
	path, err := os.Getwd()
	if err != nil {
		panic(err)
	}

	vp := viper.New()
	vp.AddConfigPath(path + "/config")        //设置读取的文件路径
	vp.SetConfigName("config")                //设置读取的文件名
	vp.SetConfigType("yaml")                  //设置文件的类型
	if err := vp.ReadInConfig(); err != nil { //尝试进行配置读取
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
