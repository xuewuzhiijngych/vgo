# Vgo

### 介绍 📖

Vgo 一款基于 Gin 开源的服务端框架，使用了Redis、Mysql、JWT、队列、等技术栈。
非常适合Golang初学者作为学习项目学习。

### 代码仓库 ⭐

- Gitee：https://gitee.com/yan_chunhao_admin/vgo.git

### 安装使用步骤 📔

- **Clone：**

```text
git clone -b dev https://gitee.com/yan_chunhao_admin/vgo.git
```

- **Install：**
- 
```text
mysql 8导入根目录sql、准备好redis
```

```text
go mod tidy
```

- **Run：**

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
│  ├─ ...
├─ job                        # 队列
├─ route                      # 路由
├─ storage                    # 日志或静态资源
│  ├─ logs                    # 日志
├─ asynq.yml                  # asynq配置文件
├─ config.yaml                # 框架配置文件
```

### 其他功能还在实现 🏗

```text 
敬请期待...
```
