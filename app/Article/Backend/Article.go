package Backend

import (
	"time"
	"ych/vgo/app/Article/Model"
	"ych/vgo/app/Common/Backend"
	"ych/vgo/internal/global"
	"ych/vgo/internal/pkg/middleware/rateLimiter"
)

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
}
