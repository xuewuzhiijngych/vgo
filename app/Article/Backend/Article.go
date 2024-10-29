package Backend

import (
	"ych/vgo/app/Article/Model"
	"ych/vgo/app/Common/Backend"
	"ych/vgo/internal/global"
)

func RegisterArticleRoutes() {
	ArticleValidateRules := map[string]map[string]string{
		"Title": {"required": "标题不能为空"},
	}

	articleHandler := Backend.NewCRUDHandler(&Model.Article{}, ArticleValidateRules)
	global.BackendRouter.GET("/articles", articleHandler.Index)
	global.BackendRouter.POST("/articles", articleHandler.Create)
	global.BackendRouter.PUT("/articles", articleHandler.Update)
	global.BackendRouter.GET("/articles/:id", articleHandler.Show)
	global.BackendRouter.DELETE("/articles", articleHandler.Delete)
}
