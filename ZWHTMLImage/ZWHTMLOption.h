//
//  ZWHTMLOption.h
//  ZWHTMLImageDemo
//
//  Created by 王子武 on 2017/6/9.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//
/**
 *  email : wang_ziwu@126.com
 *  GitHub: <https://github.com/wangziwu/ZWHTMLImage>
 *  欢迎指正，如果对您有帮助、请记得Star哦！
 */
#import <Foundation/Foundation.h>

#define OPTION_LazyLoadImgAttr  @"data-original-src"
#define OPTION_SplitURL         @"^^^"
#define OPTION_SplitIndex       @"###"
#define OPTION_HrefPrefix       @"zw-image-preview"
#define OPTION_DefaultCoreJS    @"document.getElementsByTagName('img')"
#define OPTION_StandardCoreJS   @"document.getElementsByClassName('content')[0].getElementsByTagName('img')"

@interface ZWHTMLOption : NSObject
/**
 *  遍历获取html中所有图片的核心JS
 *  默认:document.getElementsByTagName('img')。
 *  此方法会将html中所有图片遍历出来(包括头像、logo、广告推广等额外信息)
 *  用户可自定义eg
 *  简书文章:document.getElementsByClassName('content')[0].getElementsByTagName('img')
 *  则只会显示文章正文中所有图片。
 *  用户可根据所要访问地址的html实际编写规则来自定义'content'。
 */
@property (nonatomic, copy) NSString *getAllImageCoreJS;
/**
 *  图片过滤器
 *  eg:@[@"logo",@"avatars"]
 *  生成图片数组会自动过滤掉URL中包含@"logo",@"avatars"的地址
 *  避免预览图片时出现大量头像、logo等。
 */
@property (nonatomic, strong) NSArray *filterURL;
/**
 *  懒加载网页图片对面属性
 *  默认:(data-original-src)
 *  参考"简书"懒加载属性
 *  用户可依据不同网页写法调整该属性值
 */
@property (nonatomic, copy) NSString *lazyLoadImgAttribute;
/**
 *  img地址分隔符
 *  默认:(^^^)
 */
@property (nonatomic, copy) NSString *splitURL;

/**
 *  当前选择图片index分隔符
 *  默认:(###)
 */
@property (nonatomic, copy) NSString *splitIndex;

/**
 *  默认:zw-image-preview
 */
@property (nonatomic, copy) NSString *hrefPrefix;
/**
 *  默认读取ZWHTMLJS.bundle中的htmlShow.js
 *  如果js不满足业务需求，可自定义zwPreviewJS
 */
@property (nonatomic, copy) NSString *zwPreviewJS;
@end
