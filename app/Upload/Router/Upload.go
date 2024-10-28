package Router

import (
	"ych/vgo/app/Upload/Api/Local"
	"ych/vgo/internal/global"
)

func CollectRoutes() {
	global.Engine.POST("/upload/local/img", Local.ImgUpload)
	global.Engine.POST("/upload/local/video", Local.VideoUpload)
}
