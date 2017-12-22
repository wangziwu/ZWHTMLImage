//
//  ZWHTMLOption.m
//  ZWHTMLImageDemo
//
//  Created by 王子武 on 2017/6/9.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//
/**
 *  email : wang_ziwu@126.com
 *  GitHub: <https://github.com/wangziwu/ZWHTMLImage>
 *  欢迎指正，如果对您有帮助、请记得Star哦！
 */
#import "ZWHTMLOption.h"

@implementation ZWHTMLOption
-(instancetype)init{
    self = [super init];
    if (self) {
        self.getAllImageCoreJS      = OPTION_DefaultCoreJS;
        self.splitURL               = OPTION_SplitURL;
        self.splitIndex             = OPTION_SplitIndex;
        self.hrefPrefix             = OPTION_HrefPrefix;
        self.lazyLoadImgAttribute   = OPTION_LazyLoadImgAttr;
        self.zwPreviewJS            = @"";
        self.filterURL              = @[];
    }
    return self;
}
@end
