package main

import (
	"bufio"
	"fmt"
	"io"
	"os"
	"path/filepath"
	"strings"
)

func MakeCurd(moduleHandle *string, noteHandle *string) {
	// 获取模块名称
	module := *moduleHandle
	// 获取注释内容
	note := *noteHandle
	// 复制app目录下的指定文件夹并重命名保存
	newSrc := filepath.Join("api", module)
	if err := copyFolder("internal/Tpl", newSrc); err != nil {
		fmt.Println(err.Error())
		return
	}
	// 打开新的文件夹
	entries, err := os.ReadDir(newSrc)
	if err != nil {
		fmt.Println(err.Error())
		return
	}
	var renamedPaths []string // 重命名的文件路径
	// 修改文件名
	for _, entry := range entries {
		if entry.IsDir() {
			renamedPaths = append(renamedPaths, newSrc+"\\"+entry.Name()+"\\"+module+".go")
			dirPath := filepath.Join(newSrc, entry.Name())
			entries2, err := os.ReadDir(dirPath)
			if err != nil {
				fmt.Println(err.Error())
				return
			}
			// 文件重命名
			for _, entry2 := range entries2 {
				oldName := filepath.Join(dirPath, entry2.Name())
				newName := filepath.Join(dirPath, module+".go")
				if err := os.Rename(oldName, newName); err != nil {
					fmt.Println(err.Error())
					return
				}
			}
		}
	}

	// 循环 renamedPaths 数组
	for _, path := range renamedPaths {
		// 打开文件并替换指定字符串
		lowerModule := strings.ToLower(module)
		replacements := []struct {
			oldString string
			newString string
		}{
			{"Tpl", module},
			{"tpl", lowerModule},
			{"%模型名%", note},
		}

		var err error
		for _, r := range replacements {
			err = replaceInFile(path, r.oldString, r.newString)
			if err != nil {
				break
			}
		}

		if err != nil {
			fmt.Println(err.Error())
			return
		}
	}
	fmt.Println("代码生成成功，请手动注册路由~")
}

func copyFolder(src, dst string) error {
	// 获取源文件夹的信息
	srcInfo, err := os.Stat(src)
	if err != nil {
		return err
	}
	// 创建目标文件夹
	if err := os.MkdirAll(dst, srcInfo.Mode()); err != nil {
		return err
	}
	// 打开源文件夹
	entries, err := os.ReadDir(src)
	if err != nil {
		fmt.Println(err.Error())
		return err
	}
	for _, entry := range entries {
		srcPath := filepath.Join(src, entry.Name())
		dstPath := filepath.Join(dst, entry.Name())
		if entry.Name() == "代码生成模板勿动.txt" {
			continue
		}
		if entry.IsDir() {
			// 递归复制子文件夹
			if err := copyFolder(srcPath, dstPath); err != nil {
				fmt.Println(err.Error())
				return err
			}
		} else {
			// 复制文件
			if err := copyFile(srcPath, dstPath); err != nil {
				fmt.Println(err.Error())
				return err
			}
		}
	}
	return nil
}

func copyFile(src, dst string) error {
	// 打开源文件
	srcFile, err := os.Open(src)
	if err != nil {
		return err
	}
	defer func(srcFile *os.File) {
		err := srcFile.Close()
		if err != nil {
			fmt.Println(err)
			panic(err)
		}
	}(srcFile)
	// 创建目标文件
	dstFile, err := os.Create(dst)
	if err != nil {
		return err
	}
	defer func(dstFile *os.File) {
		err := dstFile.Close()
		if err != nil {
			fmt.Println(err)
			panic(err)
		}
	}(dstFile)
	// 复制文件内容
	if _, err := io.Copy(dstFile, srcFile); err != nil {
		return err
	}
	// 同步文件
	if err := dstFile.Sync(); err != nil {
		return err
	}
	return nil
}

func replaceInFile(filePath, oldString, newString string) error {
	// 打开文件
	file, err := os.OpenFile(filePath, os.O_RDWR, 0644)
	if err != nil {
		return err
	}
	defer file.Close()

	// 读取文件内容
	scanner := bufio.NewScanner(file)
	var lines []string
	for scanner.Scan() {
		line := scanner.Text()
		// 替换指定字符串
		line = strings.Replace(line, oldString, newString, -1)
		lines = append(lines, line)
	}

	// 检查扫描错误
	if err := scanner.Err(); err != nil {
		return err
	}

	// 清空文件内容
	err = file.Truncate(0)
	if err != nil {
		return err
	}
	_, err = file.Seek(0, 0)
	if err != nil {
		return err
	}

	// 写入修改后的内容
	writer := bufio.NewWriter(file)
	for _, line := range lines {
		_, err := writer.WriteString(line + "\n")
		if err != nil {
			return err
		}
	}

	// 刷新缓冲区
	return writer.Flush()
}
