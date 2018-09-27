//
//  ZWPagePickerView.m
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
#import "ZWPagePickerView.h"
@interface ZWPagePickerView ()
<UIPickerViewDelegate,
UIPickerViewDataSource>

#define ContainerHeight     120

@property (nonatomic, strong) UIPickerView *mPickerView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIButton *doneBtn;
@end
@implementation ZWPagePickerView
-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor clearColor];
        [self configDefaultUI];
    }
    return self;
}
+ (instancetype)showPagePickerView {
    ZWPagePickerView *view = [[ZWPagePickerView alloc] init];
    return view;
}
#pragma mark - config
- (void)configDefaultUI {
    [self addSubview:self.containerView];
    [self.containerView addSubview:self.mPickerView];
    [self.containerView addSubview:self.doneBtn];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hiddenAnimation];
}
#pragma mark - lifeCycle
#pragma mark - delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.maxPage;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"第%ld页",(long)row + 1];
}
#pragma mark - actionFunction
- (void)actionDone {
    NSInteger index = [self.mPickerView selectedRowInComponent:0];
    if (self.blockPagePicker) {
        self.blockPagePicker(index);
    }
    [self hiddenAnimation];
}
#pragma mark - function
- (void)showAnimation {
    [UIView animateWithDuration:0.5 animations:^{
        self.containerView.frame = CGRectMake(0, CGRectGetHeight(self.bounds)-ContainerHeight,
                                              CGRectGetWidth(self.bounds), ContainerHeight);
    }];
    [self.mPickerView reloadAllComponents];
}
- (void)hiddenAnimation {
    [UIView animateWithDuration:0.5 animations:^{
        self.containerView.frame = CGRectMake(0, CGRectGetHeight(self.bounds),
                                              CGRectGetWidth(self.bounds), ContainerHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark - layzing
- (void)setIndexPage:(NSInteger)indexPage {
    _indexPage = indexPage;
    [self.mPickerView selectRow:indexPage inComponent:0 animated:YES];
}
- (UIPickerView *)mPickerView {
    if (!_mPickerView) {
        _mPickerView = [[UIPickerView alloc] init];
        _mPickerView.frame = self.containerView.bounds;
        _mPickerView.delegate = self;
    }
    return _mPickerView;
}
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.frame = CGRectMake(0, CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), ContainerHeight);
        _containerView.backgroundColor = [UIColor whiteColor];
        _containerView.layer.cornerRadius = 10;
        _containerView.clipsToBounds = YES;
    }
    return _containerView;
}
- (UIButton *)doneBtn {
    if (!_doneBtn) {
        _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_doneBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_doneBtn addTarget:self action:@selector(actionDone) forControlEvents:UIControlEventTouchUpInside];
        _doneBtn.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds)-60, 5, 60, 30);
        [_doneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    return _doneBtn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
