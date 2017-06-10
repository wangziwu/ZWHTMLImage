//
//  ZWPreviewImageView.h
//  ZWPreviewImageDemo
//
//  Created by 王子武 on 2017/6/8.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWPreviewImageView : UIView
/** 图片数组(UIImage,URLString) */
@property (nonatomic, strong) NSArray *imageArray;
/** 标题数组 */
@property (nonatomic, strong) NSArray *titleLabArray;
/** show index*/
@property (nonatomic, assign) NSInteger showIndex;
//* indexPageLab
@property (nonatomic, strong) UILabel *indexPageLab;

/** 初始化:默认显示第1张图*/
+ (instancetype)showImageWithArray:(NSArray *)imageArray;
/** 初始化:默认显示第index位置图*/
+ (instancetype)showImageWithArray:(NSArray *)imageArray withShowIndex:(NSInteger)index;

/** 默认显示UIWindow*/
- (void)showRootWindow;
@end
