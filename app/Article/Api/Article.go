package Api

import (
	"ych/vgo/app/Article/Model"
	"ych/vgo/app/Common/Backend"
	"ych/vgo/internal/global"
)

func RegisterArticleRoutes() {
	articleHandler := Backend.NewCRUDHandler(&Model.Article{}, nil)
	global.ApiRouter.GET("/articles", articleHandler.Index)
	global.ApiRouter.GET("/articles/:id", articleHandler.Show)
}
