//
//  ZWPhotoPreviewConfig.h
//  ZWPreviewImageDemo
//
//  Created by 王子武 on 2017/12/15.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//
/**
 *  email : wang_ziwu@126.com
 *  GitHub: <https://github.com/wangziwu/ZWPreviewImage>
 *  欢迎指正，如果对您有帮助、请记得Star哦！
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//to do ...
typedef NS_ENUM(NSInteger,ZWPanDismissStyle) {
    //手势向上/向下滑动消失动画
    UpdownPandismissAnimation = 0,
    //手势-上滑消失动画
    UpPanDismissAnimation,
    //手势-下滑消失动画
    DownPanDismissAnimation,
    //禁止-手势滑动消失动画
    ForbidPanDismissAnimation
};

@interface ZWPhotoPreviewConfig : NSObject
/**
 *  左右滑动最小判断距离
 *  默认:20
 */
@property (nonatomic, assign) CGFloat dragMinDistanceCoff;
/**
 *  图片放大倍数
 *  默认: 3.0f
 */
@property (nonatomic, assign) CGFloat maxZoomScale;
/**
 *  图片缩小倍数
 *  默认: 1.0f
 */
@property (nonatomic, assign) CGFloat minZoomScale;
/**
 *  手势拖动视图
 *  视图消失临界值
 *  默认: 0.70f
 */
@property (nonatomic, assign) CGFloat dismissMaxScale;
/**
 *  图片标题字体大小
 *  默认: 17
 */
@property (nonatomic, assign) CGFloat photoTitleFontSize;
/**
 *  图片文本字体大小
 *  默认: 13
 */
@property (nonatomic, assign) CGFloat photoDescFontSize;
/**
 *  图片左右间距
 *  默认: 20
 */
@property (nonatomic, assign) CGFloat photoItemLineSpacing;
/**
 *  禁止手势拖动隐藏视图动画
 *  默认“开启”手势动画
 */
@property (nonatomic, assign) BOOL forbidPanDismiss;
/**
 *  禁止长按保存图片
 *  默认“允许”
 */
@property (nonatomic, assign) BOOL forbidLongPressSavePhoto;
/**
 *  禁止选取页码功能
 *  默认“允许”
 */
@property (nonatomic, assign) BOOL forbidPickerPage;
/**
 *  图片加载占位图
 */
@property (nonatomic, strong) UIImage *placeHolderImage;
@end
