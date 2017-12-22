//
//  ZWPagePickerView.h
//  ZWPreviewImageDemo
//
//  Created by 王子武 on 2017/12/19.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BlockPagePicker)(NSInteger indexPage);

@interface ZWPagePickerView : UIView
@property (nonatomic, assign) NSInteger maxPage;
@property (nonatomic, assign) NSInteger indexPage;
@property (nonatomic, copy) BlockPagePicker blockPagePicker;
+ (instancetype)showPagePickerView;
- (void)showAnimation;
- (void)hiddenAnimation;
@end
