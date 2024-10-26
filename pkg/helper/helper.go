package helper

import (
	"bytes"
	"encoding/json"
	"github.com/gin-gonic/gin"
	"io"
	"strings"
)

// BindJSON 处理请求参数
func BindJSON(ctx *gin.Context, obj interface{}) error {
	data, err := ctx.GetRawData()
	if err != nil {
		return err
	}
	var m map[string]interface{}
	if err := json.Unmarshal(data, &m); err != nil {
		return err
	}
	for k, v := range m {
		if str, ok := v.(string); ok {
			m[k] = strings.TrimSpace(str)
		}
	}
	data, err = json.Marshal(m)
	if err != nil {
		return err
	}
	ctx.Request.Body = io.NopCloser(bytes.NewBuffer(data))
	if err := ctx.ShouldBindJSON(obj); err != nil {
		return err
	}
	return nil
}
