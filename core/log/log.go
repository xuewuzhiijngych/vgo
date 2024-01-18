package log

import (
	"fmt"
	"go.uber.org/zap"
	"go.uber.org/zap/zapcore"
	"os"
)

var logger *zap.Logger

func MyInit() {
	config := zap.NewProductionEncoderConfig()
	config.EncodeTime = zapcore.ISO8601TimeEncoder
	fileEncoder := zapcore.NewJSONEncoder(config)
	defaultLogLevel := zapcore.DebugLevel
	path, err := os.Getwd()
	if err != nil {
		panic(err)
	}
	logFile, _ := os.OpenFile(path+"/storage/logs/vgo.log", os.O_WRONLY|os.O_CREATE|os.O_APPEND, 06666)
	writer := zapcore.AddSync(logFile)
	lg := zap.New(
		zapcore.NewCore(fileEncoder, writer, defaultLogLevel),
		zap.AddCaller(),
		zap.AddStacktrace(zapcore.ErrorLevel),
	)
	defer func(lg *zap.Logger) {
		err := lg.Sync()
		if err != nil {
			fmt.Println("日志初始化错误", err)
		}
	}(lg)
	logger = lg
}

// GetLogger 获取日志类
func GetLogger() *zap.Logger {
	return logger
}
