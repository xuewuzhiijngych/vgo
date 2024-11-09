package Router

import (
	"ych/vgo/app/Upload/Api/AliOss"
	"ych/vgo/app/Upload/Api/Auto"
	"ych/vgo/app/Upload/Api/Local"
	"ych/vgo/app/Upload/Api/TencentCos"
	"ych/vgo/internal/global"
)

func CollectRoutes() {
	global.BackendRouter.POST("/upload/local/img", Local.ImgUpload)
	global.BackendRouter.POST("/upload/local/video", Local.VideoUpload)
	global.BackendRouter.POST("/upload/oss", AliOss.Run)
	global.BackendRouter.POST("/upload/cos", TencentCos.Run)
	global.BackendRouter.POST("/upload/auto", Auto.Run)
}
