//
//  UIView+ZWFrame.h
//  YLTOA
//
//  Created by 王子武 on 2017/1/20.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZWFrame)
/**
 *  Absolute coordinate
 */
/** */
@property (nonatomic, assign) CGPoint zw_originXY;
/** */
@property (nonatomic, assign) CGSize  zw_sizeWH;
/** */
@property (nonatomic, assign) CGFloat zw_x;
/** */
@property (nonatomic, assign) CGFloat zw_y;
/** */
@property (nonatomic, assign) CGFloat zw_width;
/** */
@property (nonatomic, assign) CGFloat zw_height;

/** */
@property (nonatomic, assign) CGFloat zw_left;
/** */
@property (nonatomic, assign) CGFloat zw_top;
/** */
@property (nonatomic, assign) CGFloat zw_right;
/** */
@property (nonatomic, assign) CGFloat zw_bottom;

/** */
@property (nonatomic, assign) CGFloat zw_centerX;
/** */
@property (nonatomic, assign) CGFloat zw_centerY;

/**find responder viewController */
@property (nonatomic, strong, readonly) UIViewController *zw_viewController;
@end
