package Backend

import (
	"github.com/gin-gonic/gin"
	"time"
	"ych/vgo/app/Article/Model"
	"ych/vgo/app/Common/Backend"
	"ych/vgo/internal/global"
	"ych/vgo/internal/pkg/middleware/rateLimiter"
	"ych/vgo/pkg/helper"
	"ych/vgo/pkg/response"
)

// Change 改变状态
func Change(ctx *gin.Context) {
	var notice Model.Article
	if err := helper.BindJSON(ctx, &notice); err != nil {
		response.Fail(ctx, "参数错误", err.Error(), nil)
		return
	}
	if err := global.DbCon.Model(&Model.Article{}).Where("id = ?", notice.ID).Updates(notice).Error; err != nil {
		response.Fail(ctx, "更新失败", err.Error())
		return
	}
	response.Success(ctx, "成功", nil, nil)
}

func RegisterArticleRoutes() {
	ArticleValidateRules := &Backend.ValidationRules{
		Create: map[string]map[string]string{
			"Title": {
				"required": "标题不能为空",
				"min":      "标题长度不能少于2个字符",
			},
		},
		Update: map[string]map[string]string{
			"Title": {
				"required": "标题不能为空",
				"min":      "标题长度不能少于2666个字符",
			},
		},
	}
	articleHandler := Backend.NewCRUDHandler(&Model.Article{}, ArticleValidateRules)

	global.BackendRouter.GET("/articles", rateLimiter.Limiter(1, time.Second*1), articleHandler.Index)
	global.BackendRouter.POST("/articles", articleHandler.Create)
	global.BackendRouter.PUT("/articles", articleHandler.Update)
	global.BackendRouter.GET("/articles/:id", articleHandler.Show)
	global.BackendRouter.DELETE("/articles", articleHandler.Delete)
	global.BackendRouter.POST("/articles/change", Change)
}
