package Router

import (
	"ych/vgo/app/Upload/Api/Local"
	"ych/vgo/internal/global"
)

func CollectRoutes() {
	global.ApiRouter.POST("/upload/local/img", Local.ImgUpload)
	global.ApiRouter.POST("/upload/local/video", Local.VideoUpload)
}
