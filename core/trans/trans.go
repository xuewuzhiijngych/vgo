package trans

import (
	"encoding/json"
	"fmt"
	"io"
	"os"
	"vgo/core/global"
)

// Trans 翻译
func Trans(key string, lang string) string {
	appConf := global.App.Config.App
	if lang == "" {
		lang = appConf.Lang
	}
	path := "lang\\" + lang + "\\" + lang + ".json"
	file, err := os.Open(path)
	if err != nil {
		fmt.Println(err.Error())
		return ""
	}
	defer func(file *os.File) {
		err := file.Close()
		if err != nil {
			fmt.Println(err.Error())
		}
	}(file)

	// 读取文件内容
	bytes, err := io.ReadAll(file)
	if err != nil {
		fmt.Println(err.Error())
		return ""
	}

	// 解析JSON
	translations := make(map[string]string)
	err = json.Unmarshal(bytes, &translations)
	if err != nil {
		fmt.Println(err.Error())
		return ""
	}
	// 查找key对应的值
	if val, ok := translations[key]; ok {
		return val
	}
	fmt.Println("获取翻译出错！")
	return ""
}
