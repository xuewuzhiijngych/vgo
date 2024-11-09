package trans

import (
	"encoding/json"
	"fmt"
	"github.com/gin-gonic/gin"
	"io"
	"os"
	"strings"
	"sync"
	"ych/vgo/internal/global"
)

var (
	translationsCache = make(map[string]map[string]string)
	cacheMutex        sync.RWMutex
)

// Trans 翻译
func Trans(ctx *gin.Context, key string, values ...interface{}) string {
	var lang string
	if ctx.GetHeader("lang") != "" {
		lang = ctx.GetHeader("lang")
	} else {
		appConf := global.Config.App
		lang = appConf.Lang
	}
	// 使用读锁读取缓存
	cacheMutex.RLock()
	translations, exists := translationsCache[lang]
	cacheMutex.RUnlock()

	if !exists {
		// 缓存中没有，则加载文件并解析
		path := buildFilePath(lang)
		translations = loadTranslations(path)
		// 写锁更新缓存
		cacheMutex.Lock()
		translationsCache[lang] = translations
		cacheMutex.Unlock()
	}
	// 查找key对应的值
	if val, ok := translations[key]; ok {
		return fmt.Sprintf(val, values...)
	}
	if global.Config.App.Env == "debug" {
		fmt.Println("获取翻译出错！")
	}
	return key
}

// buildFilePath 构建文件路径
func buildFilePath(lang string) string {
	var builder strings.Builder
	builder.WriteString("i18n\\")
	builder.WriteString(lang)
	builder.WriteString("\\")
	builder.WriteString(lang)
	builder.WriteString(".json")
	return builder.String()
}

// loadTranslations 加载并解析翻译文件
func loadTranslations(path string) map[string]string {
	file, err := os.Open(path)
	if err != nil {
		fmt.Println("打开文件失败:", err.Error())
		return nil
	}
	defer file.Close()

	// 读取文件内容
	bytes, err := io.ReadAll(file)
	if err != nil {
		fmt.Println("读取文件内容失败:", err.Error())
		return nil
	}

	// 解析JSON
	var translations map[string]string
	if err := json.Unmarshal(bytes, &translations); err != nil {
		fmt.Println("解析JSON失败:", err.Error())
		return nil
	}

	return translations
}
