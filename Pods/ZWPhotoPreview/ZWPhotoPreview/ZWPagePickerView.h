//
//  ZWPagePickerView.h
//  ZWPreviewImageDemo
//
//  Created by 王子武 on 2017/12/19.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//
/**
 *  email : wang_ziwu@126.com
 *  GitHub: <https://github.com/wangziwu/ZWPreviewImage>
 *  欢迎指正，如果对您有帮助、请记得Star哦！
 */
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
