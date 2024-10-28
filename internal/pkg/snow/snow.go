package snow

import (
	"fmt"
	"github.com/bwmarrin/snowflake"
	"ych/vgo/internal/global"
)

// SnowflakeService 创建雪花算法节点
func SnowflakeService() *snowflake.Node {
	snowflakeConf := global.Config.SnowflakeConf
	// 创建雪花节点
	node, err := snowflake.NewNode(snowflakeConf.Node)
	if err != nil {
		fmt.Println("雪花Node创建失败：", err.Error())
		panic("雪花Node创建失败！！")
	}
	return node
}
