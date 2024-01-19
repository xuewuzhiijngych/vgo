package global

import (
	"github.com/spf13/viper"
	"vgo/core/config"
)

type Application struct {
	ConfigViper *viper.Viper
	Config      config.Config
}

var App = new(Application)
