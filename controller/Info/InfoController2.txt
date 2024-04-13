package Info

import (
	"github.com/gin-gonic/gin"
	"strconv"
	"vgo/core/response"
	"vgo/model/Info"
)

// Index 列表
func Index(ctx *gin.Context) {
	res := Info.Pagination(ctx)

	type InfoList struct {
		Info.Build
		Class string `json:"class"`
	}

	newList := make([]InfoList, len(res.List))
	for i, v := range res.List {
		newList[i].ID = v.ID             // 复制字段
		newList[i].Name = "Mr." + v.Name // 修改字段
		newList[i].Class = "数学"          // 新增字段
	}

	response.Success(ctx, "成功", map[string]interface{}{
		"page":     res.Page,
		"pageSize": res.PageSize,
		"total":    res.Total,
		"lists":    newList,
	}, nil)
}

// Detail 详情
func Detail(ctx *gin.Context) {
	query := Info.Detail(ctx)
	if query.ID == 0 {
		response.Fail(ctx, "数据不存在", nil, nil)
		return
	}
	type InfoDetail struct {
		Info.Build
		Class string `json:"class"`
	}
	var detail InfoDetail
	detail.Build = query
	detail.Class = "Class-----"
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

	Info.Query().Create(&Info.Build{
		Name: name,
		Age:  age,
	})
}
