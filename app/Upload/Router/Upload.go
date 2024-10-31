package Router

import (
	"ych/vgo/app/Upload/Api/Local"
	"ych/vgo/internal/global"
)

func CollectRoutes() {
	global.BackendRouter.POST("/upload/local/img", Local.ImgUpload)
	global.BackendRouter.POST("/upload/local/video", Local.VideoUpload)
}
