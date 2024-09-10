package Upload

import (
	Upload "vgo/app/Upload/Api"
	"vgo/core/router"
)

func CollectRoutes() []router.BaseRoute {
	return []router.BaseRoute{
		{"POST", "/upload/img", Upload.ImgUpload},
		{"POST", "/upload/video", Upload.VideoUpload},
	}
}
