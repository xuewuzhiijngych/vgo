package Ws

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"net/http"
	"strconv"
	"strings"
	"sync"
	"time"
	"vgo/core/global"
	"vgo/core/helper"
	"vgo/core/response"
	"vgo/core/snow"

	"github.com/gorilla/websocket"
)

var (
	upgrader = websocket.Upgrader{
		HandshakeTimeout: time.Second * 10,
		ReadBufferSize:   1024,
		WriteBufferSize:  1024,
		CheckOrigin: func(r *http.Request) bool {
			origins := global.App.Config.App.ApiOrigins
			allowedOrigins := strings.Split(origins, ",")
			// 逗号分隔的字符串
			origin := r.Header.Get("Origin")
			for _, allowedOrigin := range allowedOrigins {
				if origin == allowedOrigin {
					return true
				}
			}
			return false
		},
	}
	connections = make(map[int64]*websocket.Conn)
	mu          sync.Mutex
)

// Link 链接WebSocket
func Link(ctx *gin.Context) {
	ws, err := upgrader.Upgrade(ctx.Writer, ctx.Request, nil)
	if err != nil {
		fmt.Println(err)
		return
	}
	defer func() {
		err := ws.Close()
		if err != nil {
			fmt.Println(err)
		}
	}()

	// 生成唯一ID
	id := snow.Node().Generate()

	// 存储连接
	mu.Lock()
	connections[int64(id)] = ws
	mu.Unlock()

	// 通知客户端其ID
	err = ws.WriteMessage(websocket.TextMessage, []byte("Your ID: "+strconv.FormatInt(int64(id), 10)))
	if err != nil {
		fmt.Println(err)
		return
	}

	// 处理WebSocket消息
	for {
		messageType, p, err := ws.ReadMessage()
		if err != nil {
			fmt.Println(err)
			mu.Lock()
			delete(connections, int64(id))
			mu.Unlock()
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
			mu.Lock()
			delete(connections, int64(id))
			mu.Unlock()
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

// sendMessageToClient 发送消息给客户端
func sendMessageToClient(id int64, message []byte) error {
	mu.Lock()
	defer mu.Unlock()
	if conn, ok := connections[id]; ok {
		return conn.WriteMessage(websocket.TextMessage, message)
	}
	return fmt.Errorf("连接ID %v 不存在", id)
}

// Send 发送消息
func Send(ctx *gin.Context) {
	var params struct {
		ID      int64  `json:"id"`
		Message string `json:"message"`
	}
	if err := helper.VgoShouldBindJSON(ctx, &params); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	err := sendMessageToClient(params.ID, []byte(params.Message))
	if err != nil {
		response.Fail(ctx, err.Error(), nil)
		return
	} else {
		response.Success(ctx, "发送成功", nil)
		return
	}
}
