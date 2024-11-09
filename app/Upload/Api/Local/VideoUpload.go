package Local

import (
	"fmt"
	"github.com/gabriel-vasile/mimetype"
	"github.com/gin-gonic/gin"
	"io"
	"os"
	"path/filepath"
	"strconv"
	"time"
	"ych/vgo/internal/global"
	"ych/vgo/internal/pkg/snow"
	"ych/vgo/pkg/response"
)

// VideoUpload 视频上传
func VideoUpload(ctx *gin.Context) {
	// 获取上传的文件
	file, err := ctx.FormFile("file")
	if err != nil {
		response.Fail(ctx, "获取文件失败", err.Error(), nil)
		return
	}

	// 检查文件大小
	const maxFileSize = 50 * 1024 * 1024 // 50MB
	if file.Size > maxFileSize {
		response.Fail(ctx, fmt.Sprintf("文件大小不能超过 %d MB", maxFileSize/(1024*1024)), nil)
		return
	}

	// 打开文件
	src, err := file.Open()
	if err != nil {
		response.Fail(ctx, "无法打开文件", err.Error())
		return
	}
	defer src.Close()

	// 读取
	fileContent, err := io.ReadAll(src)
	if err != nil {
		response.Fail(ctx, "无法读取文件内容", err.Error())
		return
	}

	// 获取文件的真实类型
	mime := mimetype.Detect(fileContent)
	fileType := mime.String()

	// 检查文件类型
	allowedTypes := map[string]bool{
		"video/mp4": true,
		//.....
	}

	if !allowedTypes[fileType] {
		response.Fail(ctx, "不支持的文件类型", nil)
		return
	}

	// 获取当前日期
	now := time.Now()
	timeStr := now.Format("20060101")

	// 创建保存文件的目标路径，包含年月日子文件夹
	dstDir := filepath.Join("storage", "uploads", "video", timeStr)

	// 判断文件夹是否存在，如果不存在则创建
	if _, err := os.Stat(dstDir); os.IsNotExist(err) {
		err := os.MkdirAll(dstDir, os.ModePerm)
		if err != nil {
			response.Fail(ctx, "创建文件夹失败", err.Error())
			return
		}
	}

	// 文件重命名
	id := snow.SnowflakeService().Generate()
	ext := filepath.Ext(file.Filename) // 获取文件的后缀
	newFileName := strconv.FormatInt(int64(id), 10) + ext
	dst := filepath.Join(dstDir, newFileName)
	respUrl := "/storage/uploads/video/" + timeStr + "/" + newFileName

	// 打开上传的文件【上一次的读取操作会将文件的读写指针移到文件末尾】
	src, err = file.Open()
	if err != nil {
		response.Fail(ctx, "打开文件失败", err.Error())
		return
	}
	defer src.Close()

	// 创建目标文件
	out, err := os.Create(dst)
	if err != nil {
		response.Fail(ctx, "创建目标文件失败", err.Error())
		return
	}
	defer out.Close()

	// 将上传的文件内容复制到目标文件
	_, err = io.Copy(out, src)
	if err != nil {
		response.Fail(ctx, "保存文件失败", err.Error())
		return
	}
	imgDomain := global.Config.App.FileDomain
	response.Success(ctx, "文件上传成功", gin.H{
		"fileUrl": imgDomain + respUrl,
	}, nil)
}
