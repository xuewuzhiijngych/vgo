package User

import (
	User "vgo/app/User/Api"
	"vgo/core/router"
)

func CollectRoutes() []router.BaseRoute {
	return []router.BaseRoute{
		{"GET", "/user/personal", User.Personal},
	}
}
