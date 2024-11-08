package config

// OssConf 阿里云OSS配置
type OssConf struct {
	AccessKeyID     string `yaml:"accessKeyID"`
	AccessKeySecret string `yaml:"accessKeySecret"`
	Endpoint        string `yaml:"endPoint"`
	BucketName      string `yaml:"bucketName"`
}
