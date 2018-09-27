//
//  ZWPhotoPreview.h
//  ZWPreviewImageDemo
//
//  Created by 王子武 on 2017/12/14.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//
/**
 *  email : wang_ziwu@126.com
 *  GitHub: <https://github.com/wangziwu/ZWPreviewImage>
 *  欢迎指正，如果对您有帮助、请记得Star哦！
 */

#import <UIKit/UIKit.h>
#import "ZWPhotoPreviewDataModel.h"
#import "ZWPhotoPreviewConfig.h"
@interface ZWPhotoPreview : UIView
/**
 *  图片源
 */
@property (nonatomic, copy) NSArray<ZWPhotoPreviewDataModel *> *photoDatas;
/**
 *  默认展示图片数组下标
 *  [0~n]
 */
@property (nonatomic, assign) NSInteger showIndex;
/**
 *  相关配置
 *  (缩放系数、手势消失临界值等)
 */
@property (nonatomic, strong) ZWPhotoPreviewConfig *previewConfig;
/**
 *  show in window
 */
+ (instancetype)zw_showPhotoPreview;
+ (instancetype)zw_showPhotoPreview:(NSArray <ZWPhotoPreviewDataModel *>*)photoDatas;
@end
