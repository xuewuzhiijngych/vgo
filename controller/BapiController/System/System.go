package System

import (
	"encoding/json"
	"github.com/gin-gonic/gin"
	"io"
	"net/http"
	"vgo/core/response"
)

// GetBingBackgroundImage 获取必应每日背景图
func GetBingBackgroundImage(ctx *gin.Context) {
	isAbroad := false
	var url string
	if isAbroad {
		url = "https://bing.com/th?id=OHR.TateishiPark_ZH-CN9903501398_1920x1080.jpg&rf=LaDigue_1920x1080.jpg&pid=hp"
	} else {
		url = "https://cn.bing.com/th?id=OHR.TateishiPark_ZH-CN9903501398_1920x1080.jpg&rf=LaDigue_1920x1080.jpg&pid=hp"
	}
	response.Success(ctx, "成功", map[string]string{"url": url}, nil)
}

// getBingImageURL 获取必应每日背景图URL
func getBingImageURL(isAbroad bool, defaultURL string) (string, error) {
	var domain string
	if isAbroad {
		domain = "https://cn.bing.com"
	} else {
		domain = "https://bing.com"
	}
	resp, err := http.Get(domain + "/HPImageArchive.aspx?format=js&idx=0&n=1")
	if err != nil {
		return defaultURL, err
	}
	defer resp.Body.Close()
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return defaultURL, err
	}
	var content struct {
		Images []struct {
			URL string `json:"url"`
		} `json:"images"`
	}
	if err := json.Unmarshal(body, &content); err != nil {
		return defaultURL, err
	}
	if len(content.Images) > 0 && content.Images[0].URL != "" {
		return domain + content.Images[0].URL, nil
	}
	return defaultURL, nil

}
