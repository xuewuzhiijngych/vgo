package Info

import (
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
	"strconv"
	"vgo/core/db"
	"vgo/core/response"
	Model "vgo/model"
)

func Index(ctx *gin.Context) {
	var res []Model.Info
	pageNo, _ := strconv.Atoi(ctx.DefaultQuery("page", ""))
	Size, _ := strconv.Atoi(ctx.DefaultQuery("pageSize", ""))

	db.Con().Preload("InfoLog").Preload("InfoCard", func(db *gorm.DB) *gorm.DB {
		return db.Preload("CardLog", func(db *gorm.DB) *gorm.DB {
			return db.Where("status = ?", 1)
		})
	}).Offset(pageNo - 1).Limit(Size).Find(&res)

	for i := 0; i < len(res); i++ {
		res[i].Str = "每条额外添加"
	}

	//var ext map[int]string
	//ext = make(map[int]string, 10)
	//ext[0] = "整体额外数据1"
	//ext[1] = "整体额外数据2"

	// //定义一个数组
	//ext := [2]string{"整体额外数据1", "整体额外数据2"}

	// 定义一个切片
	ext := []string{"整体额外数据1", "整体额外数据2", "整体额外数据3"}

	response.Success(ctx, "成功", map[string]interface{}{
		"page":     pageNo,
		"pageSize": Size,
		"lists":    res,
	}, ext)
}

// Detail 详细信息
func Detail(ctx *gin.Context) {
	type NewInfo struct {
		ID   uint   `json:"id"`
		Name string `json:"name"`
		Age  int    `json:"age"`
	}

	idStr := ctx.DefaultQuery("id", "")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		response.Fail(ctx, "ID参数无效", nil)
		return
	}
	var info NewInfo
	result := db.Con().Model(&Model.Info{}).First(&info, "id = ?", uint(id))
	if result.Error != nil {
		response.Fail(ctx, "数据库查询错误", nil)
		return
	}
	response.Success(ctx, "成功", info)
}
