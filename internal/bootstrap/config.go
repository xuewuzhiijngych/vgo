package bootstrap

import (
	"fmt"
	"github.com/fsnotify/fsnotify"
	"github.com/spf13/viper"
	"path/filepath"
	"ych/vgo/internal/global"
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
		fmt.Println("检测到配置文件变化:", in.Name)
		if err := vp.Unmarshal(&global.Config); err != nil {
			fmt.Println(err)
		}
	})
	err = vp.Unmarshal(&global.Config)
	if err != nil {
		panic(err)
	}
}
