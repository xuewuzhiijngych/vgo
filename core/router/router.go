package router

import "github.com/gin-gonic/gin"

// BaseRoute 路由定义
type BaseRoute struct {
	Method  string
	Path    string
	Handler gin.HandlerFunc
}

// CollectRoutesFromModules 从多个模块收集路由
func CollectRoutesFromModules(modules ...func() []BaseRoute) []BaseRoute {
	var allRoutes []BaseRoute
	for _, module := range modules {
		allRoutes = append(allRoutes, module()...)
	}
	return allRoutes
}
