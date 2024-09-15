package User

import (
	User "vgo/app/User/Api"
	"vgo/core/router"
)

func BapiRoutes() []router.BaseRoute {
	return []router.BaseRoute{
		{"GET", "/user/personal", User.Personal},
	}
}
