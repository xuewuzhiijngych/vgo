package Info

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"vgo/db"
	"vgo/log"
	"vgo/model"
	"vgo/response"
)

func Index(ctx *gin.Context) {
	var res []model.Info
	fmt.Println(db.GetDb())
	db.GetDb().Table("info").Where("id in (?)", []int{1, 2}).Offset(0).Limit(1).Find(&res)

	url := "http://www.test.com"
	log.GetLogger().Info("write log to file",
		zap.String("url", url),
		zap.Int("attemp", 3),
	)

	response.Success(ctx, "成功", res)
}
