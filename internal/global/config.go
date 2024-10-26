package global

import (
	"fmt"
	"github.com/fsnotify/fsnotify"
	"github.com/spf13/viper"
	"path/filepath"
)

// InitConfig 初始化配置
func InitConfig() {
	vp := viper.New()
	path, err := filepath.Abs("configs")
	if err != nil {
		panic(fmt.Sprintf("获取配置路径失败: %v", err))
	}
	vp.AddConfigPath(path)
	vp.SetConfigName("config")
	vp.SetConfigType("yaml")
	if err := vp.ReadInConfig(); err != nil {
		panic(fmt.Sprintf("读取配置失败: %v", err))
	}
	vp.WatchConfig()
	vp.OnConfigChange(func(in fsnotify.Event) {
		if err := vp.Unmarshal(&Config); err != nil {
			fmt.Println(err)
		}
	})
	err = vp.Unmarshal(&Config)
	if err != nil {
		panic(err)
	}
}
