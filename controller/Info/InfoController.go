package Info

import (
	"github.com/gin-gonic/gin"
	"strconv"
	"vgo/core/helper"
	"vgo/core/response"
	"vgo/model/Info"
)

// Index 列表
func Index(ctx *gin.Context) {
	helper.Pagination(ctx, Info.TableName, Info.Build{}, "id asc", "id,name,age")
}

// Detail 详情
func Detail(ctx *gin.Context) {
	helper.First(ctx, Info.TableName, Info.Build{}, "id", "id,name,age")
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
