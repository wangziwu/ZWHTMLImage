//
//  ZWPhotoPreview.m
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
#import "ZWPhotoPreview.h"
#import "ZWPhotoPreviewCell.h"
#import "ZWPagePickerView.h"
#import "ZWPhotoAskSaveView.h"
//页码 width
#define PageShowWidth           50
//页码、remark等通用margin
#define PageShowMargin          10
//文本Scroll 高度
#define RemarkScrollHeight      120

@interface ZWPhotoPreview ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UICollectionView *mCollection;
@property (nonatomic, strong) UIImageView *maskImageView;
@property (nonatomic, strong) UIButton *pageBtn;
@property (nonatomic, strong) UIScrollView *mScroll;
@property (nonatomic, strong) UILabel *photoTitleLab;
@property (nonatomic, strong) UILabel *photoDescLab;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong) UILabel *tips;
@property (nonatomic, strong) ZWPagePickerView *pagePicker;
@property (nonatomic, strong) ZWPhotoAskSaveView *photoSaveView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) CGFloat dragStartX;
@property (nonatomic, assign) CGFloat dragEndX;
@property (nonatomic, assign) BOOL isForbidenRefresh;
@end
@implementation ZWPhotoPreview
@synthesize previewConfig = _previewConfig;
-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        [self configDefaultUI];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.containerView.frame = self.bounds;
}
#pragma mark - config
- (void)configDefaultUI {
    self.backgroundColor = [UIColor blackColor];
    [self configCollection];
    [self configPanGesture];
}
- (void)configCollection {
    [self.containerView addSubview:self.mCollection];
}
- (void)configPanGesture {
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(actionPan:)];
    [self.containerView addGestureRecognizer:panGesture];
    self.panGesture = panGesture;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(actionLongPress:)];
    [self.containerView addGestureRecognizer:longPress];
    
}
#pragma mark - lifeCycle
#pragma mark - delegate
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.previewConfig.photoItemLineSpacing;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photoDatas.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZWPhotoPreviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZWPhotoPreviewCell"
                                                                         forIndexPath:indexPath];
    ZWPhotoPreviewDataModel *model = self.photoDatas[indexPath.row];
    cell.cellModel = model;
    cell.previewConfig = self.previewConfig;
    cell.blockActionSingleTap = ^{
        [self hiddenViewAniamtion];
    };
    return cell;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.dragStartX = scrollView.contentOffset.x;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    self.dragEndX = scrollView.contentOffset.x;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self scrollItemCellToCenter];
    });
}
#pragma mark - actionFunction
- (void)actionPan:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    CGFloat alpha = 1 - fabs(translation.y/CGRectGetHeight(self.bounds) * 2);
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
            [self handlePanFollowImageViewIndex:self.currentIndex];
            self.mCollection.hidden = YES;
            self.maskImageView.hidden = NO;
        }
            break;
        case UIGestureRecognizerStateChanged: {
            self.maskImageView.center = CGPointMake(CGRectGetMidX(self.bounds) + translation.x,
                                                    CGRectGetMidY(self.bounds) + translation.y);
            self.maskImageView.transform = CGAffineTransformMakeScale(alpha, alpha);
            self.alpha = alpha;
        }
            break;
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            if (alpha>self.previewConfig.dismissMaxScale) {
                self.maskImageView.transform = CGAffineTransformIdentity;
                self.mCollection.hidden = NO;
                self.maskImageView.hidden = YES;
                self.alpha = 1;
            }else{
                [self hiddenViewAniamtion];
            }
        }
            break;
        default:
            break;
    }
}
- (void)actionLongPress:(UILongPressGestureRecognizer *)gesture {
    if (self.previewConfig.forbidLongPressSavePhoto) {
        return;
    }
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [self actionSavePhoto];
    }
}
- (void)actionSavePhoto {
    __weak typeof(self) weakSelf = self;
    self.photoSaveView = [[ZWPhotoAskSaveView alloc] init];
    [self addSubview:self.photoSaveView];
    [self.photoSaveView showAnimation];
    self.photoSaveView.blockSavePhoto = ^{
        //将图片保存到相册
        UIImageWriteToSavedPhotosAlbum([weakSelf handleShowImageView:weakSelf.currentIndex],
                                       weakSelf, @selector(saveImage:finishError:contextInfo:), NULL);
    };
}
- (void)actionSelectedPage {
    self.mCollection.hidden = NO;
    if (self.previewConfig.forbidPickerPage) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    self.pagePicker = [ZWPagePickerView showPagePickerView];
    self.pagePicker.blockPagePicker = ^(NSInteger indexPage) {
        weakSelf.currentIndex = indexPage;
        [weakSelf beginScrollToPointItem:NO];
        weakSelf.isForbidenRefresh = YES;
        weakSelf.showIndex = indexPage;
        weakSelf.isForbidenRefresh = NO;
    };
    self.pagePicker.maxPage = self.photoDatas.count;
    self.pagePicker.indexPage = self.currentIndex;
    [self addSubview:self.pagePicker];
    [self.pagePicker showAnimation];
}
#pragma mark - function
- (void)saveImage:(UIImage *) image finishError: (NSError *) error contextInfo:(void *)contextInfo{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"图片已保存到相册" ;
    }
    [self showTips:msg];
}
- (void)showTips:(NSString *)tips {
    self.tips.alpha = 1;
    self.tips.hidden = NO;
    self.tips.text = tips;
    [UIView animateWithDuration:2 animations:^{
        self.tips.alpha = 0;
    } completion:^(BOOL finished) {
        self.tips.hidden = YES;
    }];
}
- (void)handlePanFollowImageViewIndex:(NSInteger)index {
    ZWPhotoPreviewCell *cell = (ZWPhotoPreviewCell *)[self.mCollection cellForItemAtIndexPath:
                                                      [NSIndexPath indexPathForItem:index inSection:0]];
    self.maskImageView.frame = cell.photoImageView.frame;
    self.maskImageView.transform = CGAffineTransformIdentity;
    self.maskImageView.image = cell.photoImageView.image;
    self.maskImageView.hidden = YES;
}
- (UIImage *)handleShowImageView:(NSInteger)index {
    ZWPhotoPreviewCell *cell = (ZWPhotoPreviewCell *)[self.mCollection cellForItemAtIndexPath:
                                                      [NSIndexPath indexPathForItem:index inSection:0]];
    UIImage *image = cell.photoImageView.image;
    return image;
}
- (void)hiddenViewAniamtion {
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)changeIndexPageNum{
    NSString *currPageStr = [NSString stringWithFormat:@"%ld",(long)self.currentIndex + 1];
    NSString *totalPageStr = [NSString stringWithFormat:@"%lu",(unsigned long)self.photoDatas.count];
    NSString *precent = [NSString stringWithFormat:@"%@/%@",currPageStr,totalPageStr];
    [self.pageBtn setTitle:precent forState:UIControlStateNormal];
}
- (void)handleRemarkInfo {
    ZWPhotoPreviewDataModel *model = self.photoDatas[self.currentIndex];
    self.photoTitleLab.font = [UIFont systemFontOfSize:self.previewConfig.photoTitleFontSize];
    self.photoDescLab.font = [UIFont systemFontOfSize:self.previewConfig.photoDescFontSize];
    self.photoTitleLab.frame = CGRectMake(0, 0, CGRectGetWidth(self.mScroll.frame), 0);
    self.photoTitleLab.text = model.zw_photoTitle;
    [self.photoTitleLab sizeToFit];
    
    self.photoDescLab.frame = CGRectMake(0, CGRectGetMaxY(self.photoTitleLab.frame)+10,
                                         CGRectGetWidth(self.mScroll.frame), 0);
    self.photoDescLab.text = model.zw_photoDesc;
    [self.photoDescLab sizeToFit];
    
    self.mScroll.contentSize = CGSizeMake(1, CGRectGetMaxY(self.photoDescLab.frame));
    [self.mScroll setContentOffset:CGPointMake(0, 0) animated:YES];
}
- (void)handlePreviewConfig {
    if (self.previewConfig.forbidPanDismiss) {
        [self removeGestureRecognizer:self.panGesture];
    }
    self.photoTitleLab.font = [UIFont systemFontOfSize:self.previewConfig.photoTitleFontSize];
    self.photoDescLab.font = [UIFont systemFontOfSize:self.previewConfig.photoDescFontSize];
    [self handleRemarkInfo];
    [self.mCollection reloadData];
}
-(void)scrollItemCellToCenter{
    //最小滚动距离
    float  dragMinDistance = self.previewConfig.dragMinDistanceCoff;
    if (self.dragStartX - self.dragEndX >= dragMinDistance) {
        self.currentIndex -= 1; //向右
    }else if (self.dragEndX - self.dragStartX >= dragMinDistance){
        self.currentIndex += 1 ;//向左
    }
    NSInteger maxIndex  = [self.mCollection numberOfItemsInSection:0] - 1;
    self.currentIndex = self.currentIndex <= 0 ? 0 :self.currentIndex;
    self.currentIndex = self.currentIndex >= maxIndex ? maxIndex : self.currentIndex;
    [self beginScrollToPointItem:YES];
    self.isForbidenRefresh = YES;
    self.showIndex = self.currentIndex;
    self.isForbidenRefresh = NO;
}
- (void)beginScrollToPointItem:(BOOL)animated {
    [self changeIndexPageNum];
    [self handleRemarkInfo];
    [self.mCollection scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:animated];
}
#pragma mark - ExportAPI
/**
 *  show in window
 */
+ (instancetype)zw_showPhotoPreview {
    return [self zw_showPhotoPreview:nil];
}
+ (instancetype)zw_showPhotoPreview:(NSArray <ZWPhotoPreviewDataModel *>*)photoDatas {
    ZWPhotoPreview *view = [[ZWPhotoPreview alloc] init];
    view.photoDatas = photoDatas;
    [[[[UIApplication sharedApplication] delegate] window] addSubview:view];
    return view;
}
#pragma mark - layzing
-(void)setShowIndex:(NSInteger)showIndex{
    _showIndex = showIndex;
    if (!self.photoDatas.count) {
        return;
    }
    if (_showIndex>=self.photoDatas.count) {
        _showIndex = self.photoDatas.count-1;
    }
    self.currentIndex = _showIndex;
    if (self.isForbidenRefresh) {
        return;
    }
    [self beginScrollToPointItem:NO];
}
- (void)setPhotoDatas:(NSArray<ZWPhotoPreviewDataModel *> *)photoDatas {
    _photoDatas = photoDatas;
    if (photoDatas.count) {
        [self changeIndexPageNum];
        [self handleRemarkInfo];
    }else{
        [self removeFromSuperview];
    }
}
- (UICollectionView *)mCollection{
    if (!_mCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.itemSize = self.bounds.size;
        _mCollection = [[UICollectionView alloc] initWithFrame:self.bounds
                                          collectionViewLayout:layout];
        [_mCollection registerClass:[ZWPhotoPreviewCell class]
         forCellWithReuseIdentifier:NSStringFromClass([ZWPhotoPreviewCell class])];
        _mCollection.dataSource = self;
        _mCollection.delegate = self;
        //开启会影响手势
//        _mCollection.pagingEnabled = YES;
    }
    return _mCollection;
}
- (UIImageView *)maskImageView {
    if (!_maskImageView) {
        _maskImageView = [[UIImageView alloc] init];
        _maskImageView.hidden = YES;
        [self addSubview:_maskImageView];
    }
    return _maskImageView;
}
- (ZWPhotoPreviewConfig *)previewConfig {
    if (!_previewConfig) {
        _previewConfig = [[ZWPhotoPreviewConfig alloc] init];
    }
    return _previewConfig;
}
- (void)setPreviewConfig:(ZWPhotoPreviewConfig *)previewConfig {
    _previewConfig = previewConfig;
    [self handlePreviewConfig];
}
- (UIScrollView *)mScroll {
    if (!_mScroll) {
        _mScroll = [[UIScrollView alloc] init];
        CGRect frame = CGRectZero;
        frame.origin.x = 2 * PageShowMargin;
        frame.origin.y = CGRectGetHeight(self.bounds) - RemarkScrollHeight - 2 * PageShowMargin;
        frame.size.width = CGRectGetWidth(self.bounds) - 2 *frame.origin.x - PageShowWidth;
        frame.size.height = RemarkScrollHeight;
        _mScroll.frame = frame;
        _mScroll.backgroundColor = [UIColor clearColor];
        [self addSubview:_mScroll];
    }
    return _mScroll;
}
- (UILabel *)photoTitleLab {
    if (!_photoTitleLab) {
        _photoTitleLab = [[UILabel alloc] init];
        _photoTitleLab.textColor = [UIColor whiteColor];
        _photoTitleLab.numberOfLines = 0;
        [self.mScroll addSubview:_photoTitleLab];
    }
    return _photoTitleLab;
}
- (UILabel *)photoDescLab {
    if (!_photoDescLab) {
        _photoDescLab = [[UILabel alloc] init];
        _photoDescLab.textColor = [UIColor whiteColor];
        _photoDescLab.numberOfLines = 0;
        [self.mScroll addSubview:_photoDescLab];
    }
    return _photoDescLab;
}
- (UIButton *)pageBtn {
    if (!_pageBtn) {
        _pageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect frame = CGRectZero;
        frame.origin.x = CGRectGetWidth(self.bounds) - PageShowWidth - PageShowMargin;
        frame.origin.y = CGRectGetHeight(self.bounds) - PageShowWidth - PageShowMargin;
        frame.size = CGSizeMake(PageShowWidth, PageShowWidth);
        _pageBtn.frame = frame;
        _pageBtn.backgroundColor = [UIColor darkGrayColor];
        [_pageBtn setTitleColor:[UIColor whiteColor]
                       forState:UIControlStateNormal];
        _pageBtn.layer.cornerRadius = PageShowWidth * 0.5;
        [_pageBtn addTarget:self action:@selector(actionSelectedPage)
           forControlEvents:UIControlEventTouchUpInside];
        [_pageBtn.titleLabel setAdjustsFontSizeToFitWidth:YES];
        [self addSubview:_pageBtn];
    }
    return _pageBtn;
}
- (UILabel *)tips {
    if (!_tips) {
        _tips = [[UILabel alloc] init];
        _tips.textAlignment = NSTextAlignmentCenter;
        _tips.frame = CGRectMake(0, 0, 200, 40);
        _tips.center = self.center;
        _tips.layer.cornerRadius = 5;
        _tips.clipsToBounds = YES;
        _tips.textColor = [UIColor whiteColor];
        _tips.backgroundColor = [UIColor blackColor];
        _tips.hidden = YES;
        [self addSubview:_tips];
    }
    return _tips;
}
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        [self addSubview:_containerView];
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
