//
//  ZWPreviewImageCell.m
//  ZWPreviewImageDemo
//
//  Created by 王子武 on 2017/6/8.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

#import "ZWPreviewImageCell.h"
#import <ZWFrame/UIView+ZWFrame.h>
#import <SDWebImage/UIImageView+WebCache.h>
@interface ZWPreviewImageCell ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@end
#define ZWImageCellViewWidth      [[UIScreen mainScreen] bounds].size.width
#define ZWImageCellViewHeight     [[UIScreen mainScreen] bounds].size.height
@implementation ZWPreviewImageCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)layoutSubviews{
    [super layoutSubviews];
}
-(UIActivityIndicatorView *)indicator{
    if (!_indicator) {
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _indicator.hidesWhenStopped = YES;
        _indicator.center = self.contentView.center;
    }
    return _indicator;
}
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = self.bounds;
        _scrollView.maximumZoomScale = 3.0;
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.multipleTouchEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.scrollsToTop = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _scrollView.delaysContentTouches = NO;
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
        [_scrollView addGestureRecognizer:singleTap];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction:)];
        doubleTap.numberOfTapsRequired = 2;
        [_scrollView addGestureRecognizer:doubleTap];
        
        [singleTap requireGestureRecognizerToFail:doubleTap];
    }
    return _scrollView;
}
- (UILabel *)titleLab{
    if (!_titleLab){
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.font = [UIFont systemFontOfSize:15];
        _titleLab.numberOfLines = 3;
        _titleLab.zw_x = 0;
        _titleLab.zw_y = self.zw_height - 60;
        _titleLab.zw_width = self.zw_width-100;
        _titleLab.zw_height = 60;
    }
    return _titleLab;
}
- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
    }
    return _containerView;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.containerView];
        [self.containerView addSubview:self.imageView];
        [self addSubview:self.indicator];
        [self addSubview:self.titleLab];
    }
    return self;
}
-(void)setSingImage:(id)singImage{
    if ([singImage isKindOfClass:[NSString class]]) {
        [self.indicator startAnimating];
        __weak typeof(self) weakSelf = self;
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:singImage]
                          placeholderImage:nil
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                     [weakSelf resetSubviewSize];
                                     [weakSelf showAnimate];
                                     [weakSelf.indicator stopAnimating];
                                 }];
    }else if ([singImage isKindOfClass:[UIImage class]]){
        self.imageView.image = singImage;
        [self resetSubviewSize];
        [self showAnimate];
    }
}
- (void)showAnimate{
    self.imageView.transform = CGAffineTransformMakeScale(0.05, 0.05);
    [UIView animateWithDuration:0.2 animations:^{
        self.imageView.transform = CGAffineTransformMakeScale(1.00, 1.00);
    } completion:^(BOOL finished) {
        
    }];
}
- (void)resetSubviewSize{
    CGRect frame;
    frame.origin = CGPointZero;
    
    UIImage *image = self.imageView.image;
    CGFloat imageScale = image.size.height/image.size.width;
    CGFloat screenScale = ZWImageCellViewHeight/ZWImageCellViewWidth;
    if (image.size.width <= self.zw_width&& image.size.height <= self.zw_height) {
        frame.size.width = image.size.width;
        frame.size.height = image.size.height;
    } else {
        if (imageScale > screenScale) {
            frame.size.height = self.zw_height;
            frame.size.width = self.zw_height/imageScale;
        } else {
            frame.size.width = self.zw_width;
            frame.size.height = self.zw_width * imageScale;
        }
    }
    
    self.scrollView.zoomScale = 1;
    self.scrollView.contentSize = frame.size;
    [self.scrollView scrollRectToVisible:self.bounds animated:NO];
    self.containerView.frame = frame;
    self.containerView.center = self.scrollView.center;
    self.imageView.frame = self.containerView.bounds;
}

#pragma mark - 手势点击事件
- (void)singleTapAction:(UITapGestureRecognizer *)singleTap{
    if (self.actionCellSingleTap) self.actionCellSingleTap();
}

- (void)doubleTapAction:(UITapGestureRecognizer *)tap{
    UIScrollView *scrollView = (UIScrollView *)tap.view;
    
    CGFloat scale = 1;
    if (scrollView.zoomScale != 3.0) {
        scale = 3;
    } else {
        scale = 1;
    }
    CGRect zoomRect = [self zoomRectForScale:scale withCenter:[tap locationInView:tap.view]];
    [scrollView zoomToRect:zoomRect animated:YES];
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center{
    CGRect zoomRect;
    zoomRect.size.height = self.scrollView.frame.size.height / scale;
    zoomRect.size.width  = self.scrollView.frame.size.width  / scale;
    zoomRect.origin.x    = center.x - (zoomRect.size.width  /2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height /2.0);
    return zoomRect;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return scrollView.subviews[0];
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat offsetX = (scrollView.zw_width > scrollView.contentSize.width) ? (scrollView.zw_width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.zw_height > scrollView.contentSize.height) ? (scrollView.zw_height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.containerView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
}
@end
