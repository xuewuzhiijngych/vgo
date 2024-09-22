package global

import (
	"vgo/core/config"
)

type Application struct {
	Config config.Config
}

var App = new(Application)
