//
//  ZWPhotoPreviewCell.m
//  ZWPreviewImageDemo
//
//  Created by 王子武 on 2017/12/14.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//
/**
 *  email : wang_ziwu@126.com
 *  GitHub: <https://github.com/wangziwu/ZWPreviewImage>
 *  欢迎指正，如果对您有帮助、请记得Star哦！
 */
#import "ZWPhotoPreviewCell.h"
#import "ZWPhotoPreviewDataModel.h"
#import "ZWPhotoPreviewConfig.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ZWPhotoPreviewCell ()
<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *mScroll;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@end
@implementation ZWPhotoPreviewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configScrollView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.mScroll.frame = self.bounds;
}
#pragma mark - config
- (void)configScrollView {
    [self addSubview:self.mScroll];
    [self.mScroll addSubview:self.photoImageView];
    [self addSubview:self.indicator];
}
- (void)configGesture {
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(actionSingleTap)];
    [self.mScroll addGestureRecognizer:singleTap];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(actionDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.mScroll addGestureRecognizer:doubleTap];
    [singleTap requireGestureRecognizerToFail:doubleTap];
}
#pragma mark - lifeCycle
#pragma mark - delegate
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center{
    CGRect zoomRect;
    zoomRect.size.height = self.mScroll.frame.size.height / scale;
    zoomRect.size.width  = self.mScroll.frame.size.width  / scale;
    zoomRect.origin.x    = center.x - (zoomRect.size.width  * 0.5);
    zoomRect.origin.y    = center.y - (zoomRect.size.height * 0.5);
    return zoomRect;
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return [scrollView.subviews firstObject];
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat offsetX = 0.0;
    if (CGRectGetWidth(self.mScroll.bounds) > scrollView.contentSize.width) {
        offsetX = (CGRectGetWidth(self.mScroll.bounds) - self.mScroll.contentSize.width) * 0.5;
    }
    CGFloat offsetY = 0.0;
    if (CGRectGetHeight(self.mScroll.bounds) > scrollView.contentSize.height) {
        offsetY = (CGRectGetHeight(self.mScroll.bounds) - scrollView.contentSize.height) * 0.5;
    }
    CGFloat centerX = scrollView.contentSize.width * 0.5 + offsetX;
    CGFloat centerY = scrollView.contentSize.height * 0.5 + offsetY;
    self.photoImageView.center = CGPointMake(centerX, centerY);
}
#pragma mark - actionFunction
//单击消失
- (void)actionSingleTap{
    [UIView animateWithDuration:0.2 animations:^{
        self.photoImageView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        if (self.blockActionSingleTap) self.blockActionSingleTap();
    }];
}
- (void)actionDoubleTap:(UITapGestureRecognizer *)gesture{
    UIScrollView *scrollView = (UIScrollView *)gesture.view;
    CGFloat scale = 1;
    if (scrollView.zoomScale != 1) {
        scale = 1;
    }else {
        scale = self.previewConfig.maxZoomScale;
    }
    
    CGRect zoomRect = [self zoomRectForScale:scale withCenter:[gesture locationInView:gesture.view]];
    [scrollView zoomToRect:zoomRect animated:YES];
}

#pragma mark - function
- (void)resetSubviewSize{
    CGRect frame;
    frame.origin = CGPointZero;
    
    UIImage *image = self.photoImageView.image;
    CGFloat imageScale = image.size.height/image.size.width;
    CGFloat screenScale = [UIScreen mainScreen].bounds.size.height/[UIScreen mainScreen].bounds.size.width;
    if (image.size.width <= CGRectGetWidth(self.bounds)&& image.size.height <= CGRectGetHeight(self.bounds)) {
        frame.size.width = image.size.width;
        frame.size.height = image.size.height;
    } else {
        if (imageScale > screenScale) {
            frame.size.height = CGRectGetHeight(self.bounds);
            frame.size.width = CGRectGetHeight(self.bounds)/imageScale;
        } else {
            frame.size.width = CGRectGetWidth(self.bounds);
            frame.size.height = CGRectGetWidth(self.bounds) * imageScale;
        }
    }
    self.mScroll.zoomScale = 1;
    self.mScroll.contentSize = frame.size;
    [self.mScroll scrollRectToVisible:self.bounds animated:NO];
    self.photoImageView.frame = frame;
    self.photoImageView.center = self.mScroll.center;
}
#pragma mark - layzing
- (void)setCellModel:(ZWPhotoPreviewDataModel *)cellModel {
    _cellModel = cellModel;
    if (cellModel.zw_photoImage) {
        self.photoImageView.image = cellModel.zw_photoImage;
        [self resetSubviewSize];
        return;
    }
    __weak typeof(self) weakSelf = self;
    [self.indicator startAnimating];
    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:cellModel.zw_photoURL] placeholderImage:self.previewConfig.placeHolderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            weakSelf.photoImageView.image = weakSelf.previewConfig.placeHolderImage;
        }
        [weakSelf resetSubviewSize];
        if (weakSelf.photoImageView.image) {
            [weakSelf.indicator stopAnimating];
        }
    }];
}
-(UIActivityIndicatorView *)indicator{
    if (!_indicator) {
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _indicator.hidesWhenStopped = YES;
        _indicator.center = self.contentView.center;
    }
    return _indicator;
}
- (UIScrollView *)mScroll {
    if (!_mScroll) {
        _mScroll = [[UIScrollView alloc] init];
        _mScroll.frame = self.bounds;
        _mScroll.multipleTouchEnabled = YES;
        _mScroll.delegate = self;
        _mScroll.scrollsToTop = NO;
        _mScroll.showsHorizontalScrollIndicator = NO;
        _mScroll.showsVerticalScrollIndicator = NO;
        _mScroll.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _mScroll.delaysContentTouches = NO;
        [self configGesture];
    }
    return _mScroll;
}
- (FLAnimatedImageView *)photoImageView {
    if (!_photoImageView) {
        _photoImageView = [[FLAnimatedImageView alloc] init];
    }
    return _photoImageView;
}
- (void)setPreviewConfig:(ZWPhotoPreviewConfig *)previewConfig {
    _previewConfig = previewConfig;
    _mScroll.maximumZoomScale = _previewConfig.maxZoomScale;
    _mScroll.minimumZoomScale = _previewConfig.minZoomScale;
}
@end
