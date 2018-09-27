//
//  ZWPhotoPreviewConfig.m
//  ZWPreviewImageDemo
//
//  Created by 王子武 on 2017/12/15.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//
/**
 *  email : wang_ziwu@126.com
 *  GitHub: <https://github.com/wangziwu/ZWPreviewImage>
 *  欢迎指正，如果对您有帮助、请记得Star哦！
 */
#import "ZWPhotoPreviewConfig.h"

@implementation ZWPhotoPreviewConfig
- (CGFloat)dragMinDistanceCoff {
    if (!_dragMinDistanceCoff) {
        _dragMinDistanceCoff = 20.0f;
    }
    return _dragMinDistanceCoff;
}
- (CGFloat)maxZoomScale {
    if (!_maxZoomScale) {
        _maxZoomScale = 3.0f;
    }
    return _maxZoomScale;
}
- (CGFloat)minZoomScale {
    if (!_minZoomScale) {
        _minZoomScale = 1.0f;
    }
    return _minZoomScale;
}
- (CGFloat)dismissMaxScale {
    if (!_dismissMaxScale) {
        _dismissMaxScale = 0.70f;
    }
    return _dismissMaxScale;
}
- (CGFloat)photoTitleFontSize {
    if (!_photoTitleFontSize) {
        _photoTitleFontSize = 17.f;
    }
    return _photoTitleFontSize;
}
- (CGFloat)photoDescFontSize {
    if (!_photoDescFontSize) {
        _photoDescFontSize = 13.f;
    }
    return _photoDescFontSize;
}
- (CGFloat)photoItemLineSpacing {
    if (!_photoItemLineSpacing) {
        _photoItemLineSpacing = 20.0f;
    }
    return _photoItemLineSpacing;
}
@end
