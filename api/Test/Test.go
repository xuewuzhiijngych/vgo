package Test

import (
	"github.com/gin-gonic/gin"
	"vgo/internal/response"
	"vgo/internal/snow"
)

func Index(ctx *gin.Context) {
	//err := db.Con().AutoMigrate(&User.User{})
	//if err != nil {
	//	return
	//}
	//response.Success(ctx, "666", nil)
	//return
	response.Success(ctx, "666", nil)
}

func Index2(ctx *gin.Context) {
	id := snow.Node().Generate()
	response.Success(ctx, "Generated ID", id)
}
