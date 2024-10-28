package Api

import (
	"github.com/gin-gonic/gin"
	"ych/vgo/internal/pkg/snow"
	"ych/vgo/pkg/response"
)

func Test(ctx *gin.Context) {
	//ctx.JSON(http.StatusOK, gin.H{
	//	"code": http.StatusInternalServerError,
	//	"aa":   trans.Trans(ctx, "Token无效"),
	//})
	//global.Logger.Info("Request handled", zap.Any("data", "test"))
	//global.RedisCon.Set(ctx, "test", "test", 0)

	response.Success(ctx, "哈哈哈", gin.H{
		"test": snow.SnowflakeService().Generate(),
	})

	//// 生成token
	//res, err := auth.GenAdminToken(ctx, 1, []string{"哈哈"}, 1)
	//if err != nil {
	//	response.Fail(ctx, "失败", nil)
	//	return
	//}
	//response.Success(ctx, "登录成功", res)

	//client := queue.NewRedisClient()
	//defer queue.CloseRedisClient(client)
	//task, err := job.NewTestJob(42, "666666")
	//if err != nil {
	//	global.Logger.Error(fmt.Sprintf("could not create task: %v", err))
	//}
	//info, err := client.Enqueue(task)
	//if err != nil {
	//	global.Logger.Error(fmt.Sprintf("could not enqueue task: %v", err))
	//}
	//global.Logger.Info(fmt.Sprintf("enqueued task: id=%s queue=%s", info.ID, info.Queue))

	//// 打开新的文件夹
	//entries, err := os.ReadDir("app")
	//if err != nil {
	//	fmt.Println(err.Error())
	//	return
	//}
	////var renamedPaths []string // 重命名的文件路径
	//// 修改文件名
	//for _, entry := range entries {
	//	if entry.IsDir() {
	//		// 打开文件夹下的Router文件夹，如果存在的话
	//		subEntries, err := os.ReadDir(fmt.Sprintf("app/%s/Router", entry.Name()))
	//		if err != nil {
	//			fmt.Println(err.Error())
	//			continue
	//		}
	//		for _, subEntry := range subEntries {
	//			if subEntry.IsDir() {
	//				// 打开Router文件夹下的路由文件
	//				routerFilePath := fmt.Sprintf("app/%s/Router/%s/ws.go", entry.Name(), subEntry.Name())
	//				routerFile, err := os.Open(routerFilePath)
	//				if err != nil {
	//					fmt.Println(err.Error())
	//					continue
	//				}
	//				defer routerFile.Close()
	//				// 读取文件内容
	//				source, err := io.ReadAll(routerFile)
	//				if err != nil {
	//					fmt.Println(err.Error())
	//					continue
	//				}
	//				// 解析源代码
	//				fset := token.NewFileSet()
	//				node, err := parser.ParseFile(fset, "", source, parser.ParseComments)
	//				if err != nil {
	//					fmt.Println(err.Error())
	//					continue
	//				}
	//				// 进行反射，找到并调用CollectRoutes方法
	//				for _, f := range node.Decls {
	//					if funcDecl, ok := f.(*ast.FuncDecl); ok && funcDecl.Name.Name == "CollectRoutes" {
	//						// 使用反射调用CollectRoutes
	//						r := reflect.ValueOf(funcDecl).MethodByName("CollectRoutes")
	//						if r.IsValid() {
	//							r.Call(nil) // 调用方法，无参数
	//						}
	//					}
	//				}
	//			}
	//			fmt.Println(entry.Name())
	//		}
	//	}
	//}
}
