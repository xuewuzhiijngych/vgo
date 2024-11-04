package Router

import (
	"ych/vgo/app/Notice/Api"
	"ych/vgo/app/Notice/Backend"
)

func CollectRoutes() {
	Backend.RegisterNoticeRoutes()
	Api.RegisterNoticeApiRoutes()
}
