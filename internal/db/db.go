package db

import (
	"fmt"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
	"sync"
	"time"
	"vgo/internal/global"
)

// db 数据库连接
var (
	db     *gorm.DB
	dbLock sync.RWMutex
)

// InitCon 初始化数据库连接
func InitCon() {
	dbConf := global.App.Config.DbConf
	dsn := fmt.Sprintf("%v:%v@tcp(%v:%v)/%v?charset=utf8mb4&parseTime=True&loc=Local",
		dbConf.Username, dbConf.Password, dbConf.Hostname, dbConf.HostPort, dbConf.Database)
	d, err := gorm.Open(mysql.Open(dsn), &gorm.Config{
		DisableForeignKeyConstraintWhenMigrating: true, // 禁用外键约束
	})
	if err != nil {
		fmt.Println("数据库连接错误：,", err)
		panic("请检查数据库连接！！")
	}
	db = d
	sqlDB, err := db.DB()
	if err != nil {
		fmt.Println("获取数据库连接池失败：", err)
		panic("请检查数据库连接池配置！！")
	}
	sqlDB.SetMaxIdleConns(10)
	sqlDB.SetMaxOpenConns(500)
	sqlDB.SetConnMaxLifetime(time.Hour)
}

// Con 获取数据连接
func Con() *gorm.DB {
	dbLock.RLock()
	defer dbLock.RUnlock()
	return db
}
