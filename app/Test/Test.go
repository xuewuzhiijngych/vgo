package Test

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"github.com/gorilla/websocket"
	"net/http"
	"time"
)

func Index(ctx *gin.Context) {
	//err := db.Con().AutoMigrate(&Role.RoleMenu{})
	//if err != nil {
	//	return
	//}

	// 获取WebSocket连接
	wsUpgrader := websocket.Upgrader{
		HandshakeTimeout: time.Second * 10,
		ReadBufferSize:   1024,
		WriteBufferSize:  1024,
		CheckOrigin: func(r *http.Request) bool {
			return true
		},
	}
	ws, err := wsUpgrader.Upgrade(ctx.Writer, ctx.Request, nil)
	if err != nil {
		fmt.Println(err)
		return
	}
	defer func(ws *websocket.Conn) {
		err := ws.Close()
		if err != nil {
			fmt.Println(err)
			return
		}
	}(ws)

	// 处理WebSocket消息
	for {
		messageType, p, err := ws.ReadMessage()
		if err != nil {
			fmt.Println(err)
			return
		}
		switch messageType {
		case websocket.TextMessage:
			fmt.Printf("处理文本消息, %s\n", string(p))
			err := ws.WriteMessage(websocket.TextMessage, p)
			if err != nil {
				fmt.Println(err)
				return
			}
		case websocket.BinaryMessage:
			fmt.Println("处理二进制消息")
		case websocket.CloseMessage:
			fmt.Println("关闭websocket连接")
			return
		case websocket.PingMessage:
			fmt.Println("处理ping消息")
			err := ws.WriteMessage(websocket.PongMessage, []byte("ping"))
			if err != nil {
				fmt.Println(err)
				return
			}
		case websocket.PongMessage:
			fmt.Println("处理pong消息")
			err := ws.WriteMessage(websocket.PongMessage, []byte("pong"))
			if err != nil {
				fmt.Println(err)
				return
			}
		default:
			fmt.Printf("未知消息类型: %d\n", messageType)
			return
		}
	}
}
