//
//  ZWPhotoAskSaveView.h
//  ZWPreviewImageDemo
//
//  Created by 王子武 on 2017/12/20.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BlockSavePhoto)(void);
@interface ZWPhotoAskSaveView : UIView
@property (nonatomic, copy) BlockSavePhoto blockSavePhoto;
- (void)showAnimation;
@end
