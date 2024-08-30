package Common

import (
	"github.com/gin-gonic/gin"
	"vgo/core/response"
)

// GetGender 获取性别选项
func GetGender(ctx *gin.Context) {
	seed := []map[string]interface{}{
		{
			"label": "男",
			"value": 1,
		},
		{
			"label": "女",
			"value": 1,
		},
	}
	data := make([]map[string]interface{}, len(seed))
	for k, item := range seed {
		data[k] = map[string]interface{}{
			"genderLabel": item["label"],
			"genderValue": item["value"],
		}
	}
	response.Success(ctx, "成功", data, nil)
}

// GetStatus 获取状态选项
func GetStatus(ctx *gin.Context) {
	seed := []map[string]interface{}{
		{
			"label": "启用",
			"value": 1,
			"tag":   "success",
		},
		{
			"label": "禁用",
			"value": 0,
			"tag":   "danger",
		},
	}
	data := make([]map[string]interface{}, len(seed))
	for k, item := range seed {
		data[k] = map[string]interface{}{
			"tagType": item["tag"],
			"Label":   item["label"],
			"Status":  item["value"],
		}
	}
	response.Success(ctx, "成功", data, nil)
}
