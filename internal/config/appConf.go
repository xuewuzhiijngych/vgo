package config

// App 应用配置
type App struct {
	Host string `yaml:"host"`
	Port string `yaml:"port"`
	Lang string `yaml:"lang"`
}
