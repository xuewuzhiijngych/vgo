package Router

import (
	"ych/vgo/app/Article/Api"
	"ych/vgo/app/Article/Backend"
)

func CollectRoutes() {
	Backend.RegisterArticleRoutes()
	Api.RegisterArticleRoutes()
}
