package controller

import (
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"gorm.io/gorm"
	"strconv"
	"vgo/core/db"
	"vgo/core/log"
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

	url := "http://www.test.com"
	log.GetLogger().Info("write log to file",
		zap.String("url", url),
		zap.Int("attemp", 3),
		zap.Any("哦吼哈哈哈哈哈", 3),
	)

	//err := redis.Con().Set("foo", "bar", time.Minute*10).Err()
	//if err != nil {
	//	return
	//}
	//str := redis.Con().Get("foo")

	for i := 0; i < len(res); i++ {
		res[i].Str = "哈哈哈哈哈哈"
	}

	var a map[int]string
	a = make(map[int]string, 10)
	a[20095452] = "张三"
	a[20095387] = "李四"
	a[20097291] = "王五"
	a[20095387] = "朱六"
	a[20096699] = "张三"

	response.Success(ctx, "成功", map[string]interface{}{
		"page":     pageNo,
		"pageSize": Size,
		"lists":    res,
	}, a)
}

// Detail 详细信息
func Detail(ctx *gin.Context) {
	type NewInfo struct {
		ID   uint
		Name string
		Age  int
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
