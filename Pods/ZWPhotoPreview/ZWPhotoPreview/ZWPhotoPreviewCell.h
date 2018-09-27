//
//  ZWPhotoPreviewCell.h
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
@class ZWPhotoPreviewDataModel;
@class ZWPhotoPreviewConfig;
@interface ZWPhotoPreviewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *photoImageView;
/**
 *  相关配置
 *  (缩放系数、手势消失临界值等)
 */
@property (nonatomic, strong) ZWPhotoPreviewConfig *previewConfig;
@property (nonatomic, strong) ZWPhotoPreviewDataModel *cellModel;
@property (nonatomic, copy) void(^blockActionSingleTap)(void);
@end
