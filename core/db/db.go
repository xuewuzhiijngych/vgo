package db

import (
	"fmt"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
	"time"
	"vgo/core/global"
)

// db 数据库连接
var db *gorm.DB

// InitCon 初始化数据库连接
func InitCon() {
	dbConf := global.App.Config.DbConf
	dsn := fmt.Sprintf("%v:%v@tcp(%v:%v)/%v?charset=utf8mb4&parseTime=True&loc=Local",
		dbConf.Username, dbConf.Password, dbConf.Hostname, dbConf.HostPort, dbConf.Database)
	d, err := gorm.Open(mysql.Open(dsn), &gorm.Config{})
	if err != nil {
		fmt.Println("数据库连接错误：,", err)
		panic("请检查数据库连接！！")
	}
	db = d
	sqlDB, _ := db.DB()
	sqlDB.SetMaxIdleConns(10)
	sqlDB.SetMaxOpenConns(500)
	sqlDB.SetConnMaxLifetime(time.Hour)
}

// Con 获取数据连接
func Con() *gorm.DB {
	return db
}
