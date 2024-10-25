package helper

import (
	"bytes"
	"encoding/json"
	"github.com/gin-gonic/gin"
	"io"
	"strings"
)

// VgoShouldBindJSON 处理请求参数
func VgoShouldBindJSON(ctx *gin.Context, obj interface{}) error {
	data, err := ctx.GetRawData()
	if err != nil {
		return err
	}
	data, err = trimSpaces(data)
	if err != nil {
		return err
	}
	ctx.Request.Body = io.NopCloser(bytes.NewBuffer(data))
	if err := ctx.ShouldBindJSON(obj); err != nil {
		return err
	}
	return nil
}

// trimSpaces 去除请求参数中的空格
func trimSpaces(data []byte) ([]byte, error) {
	var m map[string]interface{}
	if err := json.Unmarshal(data, &m); err != nil {
		return nil, err
	}
	for k, v := range m {
		switch v := v.(type) {
		case string:
			m[k] = strings.TrimSpace(v)
		}
	}
	return json.Marshal(m)
}
