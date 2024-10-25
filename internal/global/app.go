package global

import (
	"github.com/spf13/viper"
	"vgo/configs"
)

type Application struct {
	ConfigViper *viper.Viper
	Config      configs.Config
}

var App = new(Application)
