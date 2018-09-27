//
//  ZWPhotoAskSaveView.m
//  ZWPreviewImageDemo
//
//  Created by 王子武 on 2017/12/20.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//
/**
 *  email : wang_ziwu@126.com
 *  GitHub: <https://github.com/wangziwu/ZWPreviewImage>
 *  欢迎指正，如果对您有帮助、请记得Star哦！
 */
#import "ZWPhotoAskSaveView.h"
#define ContainerHeight     120
#define ItemBtnMargin       10
#define ItemHeight          (ContainerHeight - (2 * ItemBtnMargin)) * 0.5
@interface ZWPhotoAskSaveView ()
@property (nonatomic, strong) UIButton *cancleBtn;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) UIView *containerView;
@end

@implementation ZWPhotoAskSaveView
-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor clearColor];
        [self configDefaultUI];
    }
    return self;
}
- (void)showAnimation {
    [UIView animateWithDuration:0.3 animations:^{
        self.containerView.frame = CGRectMake(0, CGRectGetHeight(self.bounds)-ContainerHeight, CGRectGetWidth(self.bounds), ContainerHeight);
    }];
}
- (void)hiddenAnimation {
    [UIView animateWithDuration:0.3 animations:^{
        self.containerView.frame = CGRectMake(0, CGRectGetHeight(self.bounds),
                                              CGRectGetWidth(self.bounds), ContainerHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hiddenAnimation];
}
#pragma mark - config
- (void)configDefaultUI {
    [self addSubview:self.containerView];
}
#pragma mark - lifeCycle
#pragma mark - delegate
#pragma mark - actionFunction
- (void)actionCancleView {
    [self hiddenAnimation];
}
- (void)actionSavePhoto {
    if (self.blockSavePhoto) {
        self.blockSavePhoto();
    }
    [self hiddenAnimation];
}
#pragma mark - function
#pragma mark - layzing
- (UIButton *)cancleBtn {
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.frame = CGRectMake(ItemBtnMargin, ItemBtnMargin + ItemHeight,
                                      CGRectGetWidth(self.bounds)-2 *ItemBtnMargin, ItemHeight);
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancleBtn.backgroundColor = [UIColor whiteColor];
        [_cancleBtn addTarget:self action:@selector(actionCancleView) forControlEvents:UIControlEventTouchUpInside];
        [_cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancleBtn.layer.cornerRadius = 10;
    }
    return _cancleBtn;
}
- (UIButton *)saveBtn {
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveBtn setTitle:@"保存到手机" forState:UIControlStateNormal];
        _saveBtn.frame = CGRectMake(ItemBtnMargin, 0,
                                    CGRectGetWidth(self.bounds)-2 *ItemBtnMargin,ItemHeight);
        _saveBtn.backgroundColor = [UIColor whiteColor];
        [_saveBtn addTarget:self action:@selector(actionSavePhoto) forControlEvents:UIControlEventTouchUpInside];
        [_saveBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _saveBtn.layer.cornerRadius = 10;
    }
    return _saveBtn;
}
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.frame = CGRectMake(0, CGRectGetHeight(self.bounds),
                                          CGRectGetWidth(self.bounds), ContainerHeight);
        [_containerView addSubview:self.saveBtn];
        [_containerView addSubview:self.cancleBtn];
    }
    return _containerView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
