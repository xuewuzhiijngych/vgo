package main

import (
	"flag"
	"fmt"
)

func main() {
	methodHandle := flag.String("method", "", "Curd")
	moduleHandle := flag.String("module", "", "模块")
	noteHandle := flag.String("note", "", "注释")
	flag.Parse()
	method := *methodHandle
	if method == "" {
		fmt.Println("请输入操作方法：例如，Curd")
		return
	}
	if method == "Curd" {
		if moduleHandle == nil || noteHandle == nil {
			fmt.Println("请输入模块和注释")
			return
		}
		fmt.Println("创建", *moduleHandle, "模块，注释：", *noteHandle)
		MakeCurd(moduleHandle, noteHandle)
		return
	}

	fmt.Println("不受支持的操作方法")
	return
}
