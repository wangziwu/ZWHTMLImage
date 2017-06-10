//
//  ZWPreviewImageView.m
//  ZWPreviewImageDemo
//
//  Created by 王子武 on 2017/6/8.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

#import "ZWPreviewImageView.h"
#import "ZWPreviewImageCell.h"
#import <ZWFrame/UIView+ZWFrame.h>
@interface ZWPreviewImageView ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation ZWPreviewImageView
-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor blackColor];
        [self initCollectionView];
        [self configBottomIndexView];
    }
    return self;
}
+ (instancetype)showImageWithArray:(NSArray *)imageArray{
    ZWPreviewImageView *showView = [[ZWPreviewImageView alloc] init];
    showView.imageArray = imageArray;
    return showView;
}
+ (instancetype)showImageWithArray:(NSArray *)imageArray withShowIndex:(NSInteger)index{
    ZWPreviewImageView *showView = [[ZWPreviewImageView alloc] init];
    showView.showIndex = index;
    showView.imageArray = imageArray;
    return showView;
}
- (void)showRootWindow{
    if (self.imageArray.count==0) {
        return;
    }
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window.rootViewController.view addSubview:self];
}
#pragma mark - 初始化CollectionView
- (void)initCollectionView{
    [self addSubview:self.collectionView];
}
- (void)configBottomIndexView{
    [self addSubview:self.indexPageLab];
}
-(void)layoutSubviews{
    [super layoutSubviews];
}
#pragma mark - function
- (void)changeIndexPageNum:(CGFloat)yPage{
    NSString *currPageStr = [NSString stringWithFormat:@"%.0f",yPage];
    NSString *totalPageStr = [NSString stringWithFormat:@"%lu",(unsigned long)self.imageArray.count];
    self.indexPageLab.text = [NSString stringWithFormat:@"%@/%@",currPageStr,totalPageStr];
}
#pragma mark - UICollectionDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZWPreviewImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZWPreviewImageCell"
                                                                      forIndexPath:indexPath];
    id object = self.imageArray[indexPath.row];
    cell.singImage = object;
    if (self.titleLabArray.count == self.imageArray.count) {
        cell.titleLab.text = self.titleLabArray[indexPath.row];
    }
    __weak typeof(self) weakSelf = self;
    cell.actionCellSingleTap = ^(){
        [weakSelf removeFromSuperview];
    };
    return cell;
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.collectionView) {
        CGFloat page = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
        [self changeIndexPageNum:page+1];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}
#pragma mark - layzing
-(void)setImageArray:(NSArray *)imageArray{
    _imageArray = imageArray;
    [self.collectionView reloadData];
    [self changeIndexPageNum:self.showIndex+1];
}
-(void)setShowIndex:(NSInteger)showIndex{
    _showIndex = showIndex;
    [self changeIndexPageNum:showIndex+1];
    [_collectionView setContentOffset:CGPointMake(showIndex*[UIScreen mainScreen].bounds.size.width, 0)];
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.itemSize = self.bounds.size;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.frame
                                             collectionViewLayout:layout];
        [_collectionView registerClass:[ZWPreviewImageCell class]
            forCellWithReuseIdentifier:@"ZWPreviewImageCell"];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
    }
    return _collectionView;
}
- (UILabel *)indexPageLab{
    if (!_indexPageLab) {
        _indexPageLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _indexPageLab.textAlignment = NSTextAlignmentRight;
        _indexPageLab.frame = CGRectMake(0, self.zw_height-30, self.zw_width-10, 20);
        _indexPageLab.font = [UIFont systemFontOfSize:15];
        _indexPageLab.textColor = [UIColor whiteColor];
    }
    return _indexPageLab;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
