package Test

import (
	"github.com/gin-gonic/gin"
	"vgo/core/response"
	"vgo/core/snow"
)

func Index(ctx *gin.Context) {
	//err := db.Con().AutoMigrate(&User.User{})
	//if err != nil {
	//	return
	//}
	//response.Success(ctx, "666", nil)
	//return

}

func Index2(ctx *gin.Context) {
	id := snow.Node().Generate()
	response.Success(ctx, "Generated ID", id)
}
