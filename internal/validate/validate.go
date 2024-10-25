package validate

import (
	"errors"
	"github.com/go-playground/validator/v10"
)

var validate *validator.Validate

func init() {
	validate = validator.New()
}

// GetInstance 获取验证器实例
func GetInstance() *validator.Validate {
	return validate
}

// Do 验证
func Do(model interface{}, rules map[string]map[string]string) (bool, string) {
	if err := validate.Struct(model); err != nil {
		var errs validator.ValidationErrors
		errors.As(err, &errs)
		var errMsg string
		for _, e := range errs {
			fieldName := e.Field()
			tag := e.Tag()
			errMsg = rules[fieldName][tag]
			if errMsg == "" {
				errMsg = e.Error()
			}
			break
		}
		return false, errMsg
	}
	return true, ""
}
