//
//  ZWPhotoPreviewConfig.m
//  ZWPreviewImageDemo
//
//  Created by 王子武 on 2017/12/15.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

#import "ZWPhotoPreviewConfig.h"

@implementation ZWPhotoPreviewConfig
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
@end
