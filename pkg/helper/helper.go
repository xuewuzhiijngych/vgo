package helper

import (
	"bytes"
	"encoding/json"
	"errors"
	"github.com/gin-gonic/gin"
	"github.com/go-playground/validator/v10"
	"io"
	"strings"
	"ych/vgo/internal/global"
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

// Validate 验证器
func Validate(model interface{}, rules map[string]map[string]string) (bool, string) {
	if err := global.Validator.Struct(model); err != nil {
		var errs validator.ValidationErrors
		if !errors.As(err, &errs) {
			return false, "验证器异常：验证失败，但未能解析错误信息"
		}
		if len(errs) > 0 {
			fieldName := errs[0].Field()
			tag := errs[0].Tag()
			if errMsg, ok := rules[fieldName][tag]; ok && errMsg != "" {
				return false, errMsg
			}
			return false, errs[0].Error()
		}
		return false, "验证器：未知错误"
	}
	return true, ""
}
