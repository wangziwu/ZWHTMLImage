//
//  ZWPhotoAskSaveView.h
//  ZWPreviewImageDemo
//
//  Created by 王子武 on 2017/12/20.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//
/**
 *  email : wang_ziwu@126.com
 *  GitHub: <https://github.com/wangziwu/ZWPreviewImage>
 *  欢迎指正，如果对您有帮助、请记得Star哦！
 */
#import <UIKit/UIKit.h>

typedef void(^BlockSavePhoto)(void);
@interface ZWPhotoAskSaveView : UIView
@property (nonatomic, copy) BlockSavePhoto blockSavePhoto;
- (void)showAnimation;
@end
