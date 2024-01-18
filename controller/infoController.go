package Info

import (
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"time"
	"vgo/core/db"
	"vgo/core/log"
	"vgo/core/redis"
	"vgo/model"
	"vgo/response"
)

func Index(ctx *gin.Context) {
	var res []model.Info
	db.GetDb().Table("infos").Where("id in (?)", []int{1, 2}).Offset(0).Limit(10).Find(&res)

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

	response.Success(ctx, "成功", res)
}
