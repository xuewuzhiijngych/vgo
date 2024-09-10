package Upload

import (
	Upload "vgo/app/Upload/Api"
	"vgo/core/router"
)

func CollectRoutes() []router.BaseRoute {
	return []router.BaseRoute{
		{"POST", "/upload/img", Upload.ImgUpload},     // 图片上传
		{"POST", "/upload/video", Upload.VideoUpload}, // 视频上传
	}
}
