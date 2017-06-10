//
//  UIView+ZWFrame.m
//  YLTOA
//
//  Created by 王子武 on 2017/1/20.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

#import "UIView+ZWFrame.h"

@implementation UIView (ZWFrame)

-(CGPoint)zw_originXY{
    return self.frame.origin;
}
-(void)setZw_originXY:(CGPoint)zw_originXY{
    CGRect newFrame = self.frame;
    newFrame.origin = zw_originXY;
    self.frame = newFrame;
}
-(CGSize)zw_sizeWH{
    return self.frame.size;
}
-(void)setZw_sizeWH:(CGSize)zw_sizeWH{
    CGRect newFrame = self.frame;
    newFrame.size = zw_sizeWH;
    self.frame = newFrame;
}
-(CGFloat)zw_x{
    return self.frame.origin.x;
}
-(void)setZw_x:(CGFloat)zw_x{
    CGRect newFrame = self.frame;
    newFrame.origin.x = zw_x;
    self.frame = newFrame;
}

-(CGFloat)zw_y{
    return self.frame.origin.y;
}
-(void)setZw_y:(CGFloat)zw_y{
    CGRect newFrame = self.frame;
    newFrame.origin.y = zw_y;
    self.frame = newFrame;
}

-(CGFloat)zw_width{
    return self.frame.size.width;
}
-(void)setZw_width:(CGFloat)zw_width{
    CGRect newFrame = self.frame;
    newFrame.size.width = zw_width;
    self.frame = newFrame;
}

-(CGFloat)zw_height{
    return self.frame.size.height;
}
-(void)setZw_height:(CGFloat)zw_height{
    CGRect newFrame = self.frame;
    newFrame.size.height = zw_height;
    self.frame = newFrame;
}

-(CGFloat)zw_left{
    return self.frame.origin.x;
}
-(void)setZw_left:(CGFloat)zw_left{
    CGRect newFrame = self.frame;
    newFrame.origin.x = zw_left;
    self.frame = newFrame;
}
-(CGFloat)zw_top{
    return self.frame.origin.y;
}
-(void)setZw_top:(CGFloat)zw_top{
    CGRect newFrame = self.frame;
    newFrame.origin.y = zw_top;
    self.frame = newFrame;
}
-(CGFloat)zw_right{
    return self.frame.origin.x+self.frame.size.width;
}
-(void)setZw_right:(CGFloat)zw_right{
    CGRect newFrame = self.frame;
    newFrame.origin.x = zw_right-self.frame.size.width;
    self.frame = newFrame;
}
-(CGFloat)zw_bottom{
    return self.frame.origin.y+self.frame.size.height;
}
-(void)setZw_bottom:(CGFloat)zw_bottom{
    CGRect newFrame = self.frame;
    newFrame.origin.y = zw_bottom-self.frame.size.height;
    self.frame = newFrame;
}

-(CGFloat)zw_centerX{
    return self.center.x;
}
-(void)setZw_centerX:(CGFloat)zw_centerX{
    CGPoint newCenter = self.center;
    newCenter.x = zw_centerX;
    self.center = newCenter;
}
-(CGFloat)zw_centerY{
    return self.center.y;
}
-(void)setZw_centerY:(CGFloat)zw_centerY{
    CGPoint newCenter = self.center;
    newCenter.y = zw_centerY;
    self.center = newCenter;
}
-(UIViewController *)zw_viewController{
    for (UIView *next = self; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
@end
