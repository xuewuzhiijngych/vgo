package Info

import (
	"github.com/gin-gonic/gin"
	"strconv"
	"vgo/core/response"
	"vgo/helper"
	"vgo/model/Info"
)

// Index 列表
func Index(ctx *gin.Context) {
	res := helper.Pagination(ctx, Info.TableName, Info.Build{})
	response.Success(ctx, "成功", map[string]interface{}{
		"page":     res.Page,
		"pageSize": res.PageSize,
		"total":    res.Total,
		"lists":    res.List,
	}, nil)
}

// Detail 详情
func Detail(ctx *gin.Context) {
	detail := helper.First(ctx, Info.TableName, Info.Build{}, "id", "id,name,age")
	response.Success(ctx, "成功", detail, nil)
}

func Create(ctx *gin.Context) {
	name := ctx.PostForm("name")
	age_ := ctx.PostForm("age")
	age, _ := strconv.Atoi(age_)

	if age <= 0 {
		response.Fail(ctx, "年龄不能为空", nil, nil)
		return
	}

	helper.GETQuery(Info.TableName).Create(&Info.Build{
		Name: name,
		Age:  age,
	})
}
