## config.yaml
```go
#App配置
app:
  host: 0.0.0.0  // 本地启动地址
  env: dev  // 环境状态：dev=开发，pro=生产
  port: 8080  // 端口号
  version: 1.0.0  // 版本号
  requestLog: 0  // 是否开启请求日志：0=关闭，1=开启，开启后会在根目录 storage/logs/vgo.log生成日志文件，记录gin的请求日志
  lang: zh-cn    // 项目基本语言
  cpuNum: 12    // 程序使用的CPU核数
  imgDomain: http://localhost:8080   // 图片域名
  videoDomain: http://localhost:8080  // 视频域名
  apiOrigins: http://localhost:8080,http://127.0.0.1:5500 // 可跨域请求的域名，注意不要空着，否则会启动异常
#Mysql数据库配置
dbConf:
  driver: mysql
  hostname: 127.0.0.1
  hostPort: 3306
  database: go_study
  username: root
  password: 110112...
#Redis数据库配置
redisConf:
  hostname: 127.0.0.1
  hostPort: 6379
  username:
  password: 
  db: 11
#队列配置
queueConf:
  enable: 0
  hostname: 127.0.0.1
  hostPort: 6379
  username:
  password:
  db: 12
  concurrency: 10
#JWT配置
jwtConf:
  adminKey: pDxCHgMzlarDuWFeDVSlQNHyZVoxeBfJsGVz
  adminSingleLogin: 1   // 是否开启bapi相关的单设备登录
  apikey: pDxCHgMzlarDuWFeDVSlQNHyZVssssssssszxz
  apiSingleLogin: 1   // 是否开启api相关的单设备登录
  adminTimeout: 24    // bapi登录超时时间，单位：小时
  apiTimeout: 24     // api登录超时时间，单位：小时
#Snowflake配置
snowflakeConf:
  node: 1  // 节点号-单服务节点写1即可，多节点部署，自己分配，具体逻辑，参考网络雪花ID算法原理
```