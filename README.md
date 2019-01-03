# ZWHTMLImage
[![Version](https://img.shields.io/cocoapods/v/ZWHTMLImage.svg?style=flat)](http://cocoadocs.org/docsets/ZWHTMLImage)
[![License](https://img.shields.io/cocoapods/l/ZWHTMLImage.svg?style=flat)](http://cocoadocs.org/docsets/ZWHTMLImage)
[![Platform](https://img.shields.io/cocoapods/p/ZWHTMLImage.svg?style=flat)](http://cocoadocs.org/docsets/ZWHTMLImage)
![Language](https://img.shields.io/badge/Language-%20Objective%20C%20-blue.svg)

### 我的简书文章地址
详情使用介绍请查看[我的简书](http://www.jianshu.com/p/aa2f1dc8dff7)

[iOS极简模式实现Webview网页图片原生预览](http://www.jianshu.com/p/aa2f1dc8dff7)

> iOS快速实现对WEB网页、HTML的native图片预览功能。

> 两行代码调用、同时支持UIWebView与WKWebView。

> 支持懒加载（滚动加载）类型HTML网页

### 框架整体介绍
- [x] 该框架为一个通用HTML图片预览框架，旨在提供一种简单快捷的调用方式来native预览网页图片。
- [x] 同时支持UIWebView与WKWebView。
- [x] 支持GIF图片预览显示。
- [x] 支持网页图片自定义过滤规则。过滤“头像、广告”之类的小图标。
- [x] 支持用户自定义核心抓取图片JS、自定义解析规则。
- [x] 支持配置参数确定是否仅抓取正文（conent）部分图片。

### 效果展示

![HTMLImage.gif](http://upload-images.jianshu.io/upload_images/3237547-a10a31a222c65251.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 如何使用SDK
强烈建议您使用pod导入，节省导入依赖的时间。

* 使用cocoaPods导入(搜索不到请更新本地仓库)

```
pod 'ZWHTMLImage',       '~> 0.0.4'
```
* 直接将文件ZWHTMLImage拖入工程中


 依赖[ZWPhotoPreview](https://github.com/wangziwu/ZWPreviewImage)图片显示框架。

```
#import "ZWHTMLSDK.h"
```
### 关于图片保存权限
* 长按保存功能需要用户info.plist中配置权限
```
Privacy - Photo Library Additions Usage Description
```
```
Privacy - Photo Library Usage Description
```

### v0.0.4版本更新记录

- 【新增】: 支持GIF图片预览显示

### v0.0.3版本更新记录

- 【更新】: 更新SDWebImage版本至4.0.0

### v0.0.2版本更新记录

- 【新增】: 支持懒加载类型网页图片的读取功能。

- 【修改】: 重新构造图片预览功能、更新图片预览框架ZWPhotoPreview最新版本。

- 【新增】: 提供图片快速预览、手势拖放动画、手势缩放、长按保存、页码选择等最新功能。

### v0.0.1版本更新记录
- 【新增】: 提供简便的HTML图片放大预览功能。
- 【新增】: 提供简便的HTML图片过滤功能、用户自定义过滤参数。
- 【新增】: cocoapods支持。
