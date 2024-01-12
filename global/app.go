package global

import (
	"github.com/spf13/viper"
	"vgo/config"
)

type Application struct {
	ConfigViper *viper.Viper
	Config      config.Config
}

var App = new(Application)
