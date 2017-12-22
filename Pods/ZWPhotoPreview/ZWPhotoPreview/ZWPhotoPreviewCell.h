//
//  ZWPhotoPreviewCell.h
//  ZWPreviewImageDemo
//
//  Created by 王子武 on 2017/12/14.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

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
