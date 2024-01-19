package Info

import (
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"strconv"
	"time"
	"vgo/core/db"
	"vgo/core/log"
	"vgo/core/redis"
	"vgo/model"
	"vgo/response"
)

func Index(ctx *gin.Context) {
	var res []model.Info

	page := ctx.DefaultQuery("page", "")
	pageSize := ctx.DefaultQuery("page_size", "")
	pageNo, _ := strconv.Atoi(page)
	Size, _ := strconv.Atoi(pageSize)

	//Where("id in (?)", []int{1, 2})
	db.GetCon().Table("infos").Offset(pageNo - 1).Limit(Size).Find(&res)
	//var totalCount int64
	//totalCount, _ = db.GetCon().Table("infos").Count()

	url := "http://www.test.com"
	log.GetLogger().Info("write log to file",
		zap.String("url", url),
		zap.Int("attemp", 3),
	)

	err := redis.GetCon().Set("foo", "bar", time.Minute*10).Err()
	if err != nil {
		return
	}

	str := redis.GetCon().Get("foo")
	for i := 0; i < len(res); i++ {
		res[i].Str = str.Val()
	}

	//var a map[int]string
	//a = make(map[int]string, 10)
	//a[20095452] = "张三"
	//a[20095387] = "李四"
	//a[20097291] = "王五"
	//a[20095387] = "朱六"
	//a[20096699] = "张三"
	//res = append(res, model.Info{Extend: a})

	response.Success(ctx, "成功", map[string]interface{}{
		"page":     pageNo,
		"pageSize": pageSize,
		"lists":    res,
	}, nil)
}
