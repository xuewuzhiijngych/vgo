package AliOss

import (
	"fmt"
	"github.com/aliyun/aliyun-oss-go-sdk/oss"
	"github.com/gin-gonic/gin"
	"mime/multipart"
	"path/filepath"
	"strings"
	"time"
	"ych/vgo/app/Upload/Common"
	"ych/vgo/internal/global"
	"ych/vgo/pkg/response"
)

func Run(ctx *gin.Context) {
	form, err := ctx.MultipartForm()
	if err != nil {
		fmt.Println("文件解析失败:", err)
		return
	}
	files := form.File["file"]
	var fileUrl string
	for _, file := range files {
		fileName := file.Filename
		fileType := filepath.Ext(fileName)
		if fileType == "" {
			fmt.Println("文件解析失败: 文件没有扩展名")
			continue
		}
		newFile := Upload.RandomFileName() + "." + fileType
		if err, fileUrl = upload(newFile, file); err != nil {
			response.Fail(ctx, err.Error(), nil)
			return
		}
	}
	response.Success(ctx, "Oss文件上传成功", gin.H{
		"fileUrl": fileUrl,
	}, nil)
}

// 上传文件到OSS
func upload(filename string, s1 *multipart.FileHeader) (err error, signedURL string) {
	// OSS配置
	config := global.Config.OssConf
	accessKeyID := config.AccessKeyID
	accessKeySecret := config.AccessKeySecret
	endpoint := config.Endpoint
	bucketName := config.BucketName
	// 客户端
	client, err := oss.New(endpoint, accessKeyID, accessKeySecret)
	if err != nil {
		return err, ""
	}
	// 存储桶
	bucket, err := client.Bucket(bucketName)
	if err != nil {
		return err, ""
	}
	today := time.Now().Format("20060102")
	objectKey := today + "/" + filename
	isExist, err := bucket.IsObjectExist(today + "/")
	if err != nil {
		return err, ""
	}
	if !isExist {
		err = bucket.PutObject(today+"/", strings.NewReader(""))
		if err != nil {
			return err, ""
		}
	}
	fileInfo, err := s1.Open()
	if err != nil {
		return err, ""
	}
	// 上传文件对象
	err = bucket.PutObject(objectKey, fileInfo)
	if err != nil {
		return err, ""
	}
	// 生成链接
	signedURL, err = bucket.SignURL(objectKey, oss.HTTPGet, 31536000000)
	if err != nil {
		return err, ""
	}
	return nil, signedURL
}
