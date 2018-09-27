//
//  ZWPhotoPreviewDataModel.m
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
#import "ZWPhotoPreviewDataModel.h"

@implementation ZWPhotoPreviewDataModel
/**
 *  图片URL/UIImage数组
 *  转换Model
 */
+ (NSArray <ZWPhotoPreviewDataModel *> *)transformPhotoURLArray:(NSArray *)urlArray {
    NSMutableArray *mutArray = [NSMutableArray array];
    [urlArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZWPhotoPreviewDataModel *model = [[ZWPhotoPreviewDataModel alloc] init];
        if ([obj isKindOfClass:[UIImage class]]) {
            model.zw_photoImage = obj;
        }else if ([obj isKindOfClass:[NSString class]]){
            model.zw_photoURL = obj;
        }else{
            model.zw_photoURL = @"";
        }
        [mutArray addObject:model];
    }];
    return mutArray;
}
@end
