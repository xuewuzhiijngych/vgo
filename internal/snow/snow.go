package snow

import (
	"fmt"
	"github.com/bwmarrin/snowflake"
	"vgo/internal/global"
)

var node *snowflake.Node

// InitSnowflake 初始化雪花算法
func InitSnowflake() {
	snowflakeConf := global.App.Config.SnowflakeConf
	// 创建雪花节点
	n, err := snowflake.NewNode(snowflakeConf.Node)
	if err != nil {
		fmt.Println("雪花Node创建失败：", err.Error())
		panic("雪花Node创建失败！！")
	}
	node = n
}

// Node 获取雪花算法节点
func Node() *snowflake.Node {
	return node
}
