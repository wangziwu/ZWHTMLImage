//
//  ZWHTMLSDK.h
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
#import "ZWHTMLOption.h"

typedef void(^BlockHandlePreview)(NSArray *allImageArray, NSInteger index);

@interface ZWHTMLSDK : NSObject
/** config setting*/
@property (nonatomic, readonly) ZWHTMLOption *zw_option;
@property (nonatomic, copy)     BlockHandlePreview blockHandlePreview;
/*
 *  how to use:
 *  UIWebView
 *  webViewDidFinishLoad加载完成之后调用
 *  WKWebView
 *  didFinishNavigation加载完成之后调用
 *  load:defaultCoreJS
 */
+ (instancetype)zw_loadBridgeJSWebview:(id)webView;

/**
 * load:standardCoreJS(仅加载正文content中所有图片)
 */
+ (instancetype)zw_loadStandardBridgeJSWebview:(id)webView;

/*
 *  how to use:
 *  option:可选项
 *  config:过滤词汇、coreJS、split等
 */
+ (instancetype)zw_loadBridgeJSWebview:(id)webView withOption:(ZWHTMLOption *)option;
/*
 *  how to use:
 *  UIWebView/WKWebView：shouldStartLoadWithRequest之后调用
 *  YES:代表需要执行图片预览功能.
 *  NO:代表其他HTML网络请求。根据业务自定义处理。
 */
- (BOOL)zw_handlePreviewImageRequest:(NSURLRequest *)request;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
@end
