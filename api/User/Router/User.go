package User

import (
	User "vgo/api/User/Api"
	"vgo/internal/router"
)

func CollectRoutes() []router.BaseRoute {
	return []router.BaseRoute{
		{"GET", "/user/personal", User.Personal},
	}
}
