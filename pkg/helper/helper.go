package helper

import (
	"bytes"
	"crypto/md5"
	"encoding/hex"
	"encoding/json"
	"errors"
	"github.com/gin-gonic/gin"
	"github.com/go-playground/validator/v10"
	"gorm.io/gorm"
	"io"
	"strings"
	"ych/vgo/internal/global"
	"ych/vgo/pkg/response"
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

// HandleErr 统一错误处理
func HandleErr(ctx *gin.Context, err error, msg string) bool {
	if errors.Is(err, gorm.ErrRecordNotFound) {
		response.Fail(ctx, "数据不存在", err.Error(), nil)
		return true
	}
	if err != nil {
		response.Fail(ctx, msg, err.Error(), nil)
		return true
	}
	return false
}

// BindAndValidate 参数绑定和验证简化
func BindAndValidate(ctx *gin.Context, obj interface{}, rules map[string]map[string]string) bool {
	if err := BindJSON(ctx, obj); HandleErr(ctx, err, "参数错误") {
		return false
	}
	if rules != nil {
		if res, err := Validate(obj, rules); !res {
			response.Fail(ctx, err, nil)
			return false
		}
	}
	return true
}

// MakeMd5 md5加密
func MakeMd5(str string) string {
	h := md5.New()
	h.Write([]byte(str))
	return hex.EncodeToString(h.Sum(nil))
}
