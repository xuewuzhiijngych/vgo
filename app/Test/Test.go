package Test

import (
	"github.com/casbin/casbin/v2"
	"github.com/casbin/casbin/v2/model"
	gormadapter "github.com/casbin/gorm-adapter/v3"
	"github.com/gin-gonic/gin"
	Role "vgo/app/Role/Model"
	"vgo/core/db"
)

func Index(ctx *gin.Context) {
	//res := time.Duration(global.App.Config.JwtConf.Timeout)
	//response.Success(ctx, "成功", map[string]interface{}{}, res)

	//query := db.GetCon().Model(&Product.Product{}).Find(&Product.Product{})
	//response.Success(ctx, "查询成功", query, nil)

	err := db.Con().AutoMigrate(&Role.RoleMenu{})
	if err != nil {
		return
	}

	//enforcer := casbinCore.SetupCasbin()
	////user, err := enforcer.AddRolesForUser(strconv.Itoa(1), []string{"admin"})
	////if err != nil {
	////	return
	////}
	////response.Success(ctx, "添加成功", user, nil)
	//
	//res, err := enforcer.AddPolicy("admin", "/notice")
	//if err != nil {
	//	return
	//}
	//response.Success(ctx, "添加成功", res, nil)

	//enforcer := casbin2.SetupCasbin()
	//updated, err := enforcer.UpdatePolicy([]string{"admin", "/admin/notice"}, []string{"admin", "/admin/notice1"})
	//if err != nil {
	//	response.Fail(ctx, err.Error(), nil)
	//}
	//response.Success(ctx, "添加成功", updated, nil)

}

func InitCasbin() {
	text := `
		[request_definition]
		r = sub, obj, act
		
		[policy_definition]
		p = sub, obj, act
		
		[role_definition]
		g = _, _
		
		[policy_effect]
		e = some(where (p.eft == allow))
		
		[matchers]
		m = g(r.sub, p.sub) && keyMatch2(r.obj, p.obj) && r.act == p.act
		`
	m, err := model.NewModelFromString(text)
	if err != nil {
		return
	}
	adapter, _ := gormadapter.NewAdapterByDB(db.Con())
	_, _ = casbin.NewSyncedCachedEnforcer(m, adapter)
}
