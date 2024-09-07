package Test

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"net/http"
	"sync"
	"time"
	"vgo/core/response"

	"github.com/gorilla/websocket"
)

var (
	upgrader = websocket.Upgrader{
		HandshakeTimeout: time.Second * 10,
		ReadBufferSize:   1024,
		WriteBufferSize:  1024,
		CheckOrigin: func(r *http.Request) bool {
			origin := r.Header.Get("Origin")
			allowedOrigins := []string{
				"http://localhost:8080",
				"http://127.0.0.1:5500",
			}
			for _, allowedOrigin := range allowedOrigins {
				if origin == allowedOrigin {
					return true
				}
			}
			return false
		},
	}
	connections = make(map[string]*websocket.Conn)
	mu          sync.Mutex
)

func Index(ctx *gin.Context) {
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
	id := generateUniqueID()

	// 存储连接
	mu.Lock()
	connections[id] = ws
	mu.Unlock()

	// 通知客户端其ID
	err = ws.WriteMessage(websocket.TextMessage, []byte("Your ID: "+id))
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
			delete(connections, id)
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
			delete(connections, id)
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
func generateUniqueID() string {
	// 这里可以使用UUID生成器或其他唯一ID生成方法
	// 为了简单起见，这里使用一个递增的整数
	return fmt.Sprintf("%d", time.Now().UnixNano())
}

// sendMessageToClient 发送消息给客户端
func sendMessageToClient(id string, message []byte) error {
	mu.Lock()
	defer mu.Unlock()
	if conn, ok := connections[id]; ok {
		return conn.WriteMessage(websocket.TextMessage, message)
	}
	return fmt.Errorf("连接ID %s 不存在", id)
}

func SendWs(ctx *gin.Context) {
	var params struct {
		ID      string `json:"id"`
		Message string `json:"message"`
	}
	if err := ctx.ShouldBindJSON(&params); err != nil {
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
