# Vgo

### 介绍 📖

Vgo 是一款基于 Gin 开发的开源服务端框架。
- 使用了Redis、Mysql、JWT、队列、等技术栈。
- 比较适合Golang初学者作为学习项目学习。
- 当前框架内实现了基本的Rbac权限管理（使用casbin）、队列、websocket、文件日志等功能。
- 后续将陆续增加更多功能，欢迎大家共同参与进来。
- 本项目主要是为了学习 Golang 而开发的，所以代码中难免有不足之处，还请大家多多包涵。

### 代码仓库 ⭐(记得 Star⭐)

- Vgo-Github：https://github.com/xuewuzhiijngych/vgo.git
- Vgo-Gitee：https://gitee.com/yan_chunhao_admin/vgo.git
- 
- VgoAdmin-Github：https://github.com/xuewuzhiijngych/vgo-admin.git
- VgoAdmin-Gitee：https://gitee.com/yan_chunhao_admin/vgo-admin.git

### 安装使用步骤 📔

- **下载：**

```text
git clone -b https://github.com/xuewuzhiijngych/vgo.git
```

- **安装：**

- 使用Mysql8，导入根目录的go_study.sql文件。
- 准备redis
- 修改根目录下的config.yaml文件，配置Mysql、Redis、JWT等信息。
- 根目录的asynq.yml文件是配置asynq命令工具的，不使用，忽略即可。
- 执行以下命令安装依赖包：

```text
go mod tidy
```

- **运行：**

```text
go run main.go
```

### 项目目录 📚

```text
Vgo
├─ app                        # Vite 配置项
├─ AdminUser                  # 模块
│  ├─ Bapi                    # Bapi 后台接口
│  ├─ Api                     # Api 前台接口
│  ├─ Model                   # Model 模型
│  ├─ Router                  # Router 路由
├─ bootstrap                  # 框架启动文件
├─ core                       # 框架核心文件
│  ├─ ...                     # 后续出详细介绍（亦可以自己通过源码了解）
├─ job                        # 队列
├─ route                      # 路由
├─ storage                    # 日志或静态资源
│  ├─ logs                    # 日志
├─ asynq.yml                  # asynq配置文件
├─ config.yaml                # 框架配置文件
```

### 前台使用 🌎
- 基于本框架的接口，实现了一个拥有简单Rbac的后台管理系统，具体使用方法请参考VgoAdmin项目。
- 前端项目地址：https://github.com/xuewuzhiijngych/vgo-admin.git


### 代码生成 🏢
- 生成基本增删改查的golang代码，可使用命令：
```text
go run vTools.go --module=Product --note=产品
```
- 执行代码后，会在app目录下生成一个Product模块，里面包含了增删改查的相关代码。
- 随后需要自己在根目录route/router.go文件中注册路由。【后期实现自动注册】

### 后续计划 🔮
- 后续将陆续增加更多功能，欢迎大家共同参与进来。
- 如有任何问题，请联系作者：<601266867@qq.com>