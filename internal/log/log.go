package log

import (
	"fmt"
	"go.uber.org/zap"
	"go.uber.org/zap/zapcore"
	"os"
)

// InitLogDriver 初始化日志驱动
func InitLogDriver() *zap.Logger {
	config := zap.NewProductionEncoderConfig()
	config.EncodeTime = zapcore.ISO8601TimeEncoder
	fileEncoder := zapcore.NewJSONEncoder(config)
	defaultLogLevel := zapcore.DebugLevel
	path, err := os.Getwd()
	if err != nil {
		fmt.Printf("日志目录获取失败: %v\n", err)
		return nil
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
	return lg
}
