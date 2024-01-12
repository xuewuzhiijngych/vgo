package main

import (
	"fmt"
	"runtime"
	"strconv"
	"vgo/bootstrap"
)

func main() {
	cpuNum, _ := strconv.Atoi("8")
	realCpuNum := runtime.NumCPU()
	if cpuNum > realCpuNum {
		cpuNum = realCpuNum
	}
	if cpuNum > 0 {
		runtime.GOMAXPROCS(cpuNum)
		fmt.Printf("当前计算机核数: %v个,调用：%v个\n", realCpuNum, cpuNum)
	} else {
		runtime.GOMAXPROCS(realCpuNum)
		fmt.Printf("当前计算机核数: %v个,调用：%v个\n", realCpuNum, cpuNum)
	}

	bootstrap.Start()
}
