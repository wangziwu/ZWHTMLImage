# ZWPreviewImage

[![Version](https://img.shields.io/cocoapods/v/ZWPhotoPreview.svg?style=flat)](http://cocoadocs.org/docsets/ZWPhotoPreview)
[![License](https://img.shields.io/cocoapods/l/ZWPhotoPreview.svg?style=flat)](http://cocoadocs.org/docsets/ZWPhotoPreview)
[![Platform](https://img.shields.io/cocoapods/p/ZWPhotoPreview.svg?style=flat)](http://cocoadocs.org/docsets/ZWPhotoPreview)
![Language](https://img.shields.io/badge/Language-%20Objective%20C%20-blue.svg)

> 简单易用的图片预览器。

> 支持左右滑动查看图片、手势拖动取消动画、图片单击隐藏、双击放大、长按保存。

> 支持UIImage、URLString格式。

> 支持显示标题、文本、页码。

### 效果展示

![HTMLImage.gif](http://upload-images.jianshu.io/upload_images/3237547-a10a31a222c65251.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 如何使用SDK
强烈建议您使用pod导入，节省导入依赖的时间。

* 使用cocoaPods导入(搜索不到请更新本地仓库)

```
pod 'ZWPhotoPreview',       '~> 0.1.3'
```
* 直接将文件ZWPhotoPreview拖入工程中

 依赖[SDWebImage](https://github.com/rs/SDWebImage)图片显示框架。

#### 导入头文件

```
#import "ZWPhotoPreview.h"
```

### v0.1.3版本更新记录
* 【新增】: 页码选择功能、点击页码按钮弹出滚动选择框、快速定位到指定图片。
* 【新增】: 页码功能配置项、可通过forbidPickerPage来禁止页码选择功能。
* 【新增】: 默认加载图片配置项、可以通过placeHolderImage配置SDWebImage图片默认加载图。
* 【新增】: 长按保存图片功能配置项、可通过forbidLongPressSavePhoto来禁止长按保存功能。

### v0.1.2版本更新记录
* 【新增】: 手势拖动视图动画消失配置项、可通过forbidPanDismiss来禁止手势拖动功能。

### v0.1.1版本更新记录
* 【新增】: 添加配置项功能、可配置相关参数。
* 【修改】: 修改配置项崩溃问题。

### v0.1.0版本更新记录
* 【新增】: 重新构造图片预览功能、提供更加简洁方便且功能齐全的图片预览器。
* 【新增】: 提供左右滑动切换视图、手势拖放动画、单击隐藏、双击放大、长按保存、页码选择等齐全的功能。

### v0.0.1版本更新记录
* 【新增】: 提供简便的图片预览器。





