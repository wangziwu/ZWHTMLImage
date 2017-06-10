//
//  ZWPreviewImageCell.h
//  ZWPreviewImageDemo
//
//  Created by 王子武 on 2017/6/8.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CallBackCellSingleTap)(void);

@interface ZWPreviewImageCell : UICollectionViewCell
/** */
@property (nonatomic, copy) id singImage;
/** 标题 */
@property (nonatomic, strong) UILabel *titleLab;
/** */
@property (nonatomic, copy) CallBackCellSingleTap actionCellSingleTap;
@end
