package Test

import (
	"github.com/gin-gonic/gin"
	"vgo/core/response"
	"vgo/core/snow"
)

func Index2(ctx *gin.Context) {
	id := snow.Node().Generate()
	response.Success(ctx, "Generated ID", id)
}
