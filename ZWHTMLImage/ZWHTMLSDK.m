//
//  ZWHTMLSDK.m
//  ZWHTMLImageDemo
//
//  Created by 王子武 on 2017/6/9.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

#import "ZWHTMLSDK.h"
#import <ZWPreviewImage/ZWPreviewImageView.h>
#import <WebKit/WebKit.h>
@implementation ZWHTMLSDK
- (instancetype)zwHTML_init{
    return [super init];
}
+ (instancetype)zw_loadBridgeJSWebview:(id)webView{
    return [self zw_loadBridgeJSWebview:webView withOption:nil];
}
+ (instancetype)zw_loadStandardBridgeJSWebview:(id)webView{
    ZWHTMLOption *option = [[ZWHTMLOption alloc] init];
    option.getAllImageCoreJS = OPTION_StandardCoreJS;
    return [self zw_loadBridgeJSWebview:webView withOption:option];
}
+ (instancetype)zw_loadBridgeJSWebview:(id)webView withOption:(ZWHTMLOption *)option{
    ZWHTMLSDK *htmlSDK = [[ZWHTMLSDK alloc] zwHTML_init];
    htmlSDK.zw_option = option;
    if (!htmlSDK.zw_option) {
        htmlSDK.zw_option = [[ZWHTMLOption alloc] init];
    }
    if ([webView isKindOfClass:[UIWebView class]]) {
        [webView stringByEvaluatingJavaScriptFromString:[self configPreviewJS:htmlSDK.zw_option]];
    }else if ([webView isKindOfClass:[WKWebView class]]){
        [webView evaluateJavaScript:[self configPreviewJS:htmlSDK.zw_option] completionHandler:nil];
    }
    return htmlSDK;
}
- (BOOL)zw_handlePreviewImageRequest:(NSURLRequest *)request{
    if (!self.zw_option) {
        self.zw_option = [[ZWHTMLOption alloc] init];
    }
    if ([request.URL.scheme isEqualToString:self.zw_option.hrefPrefix]) {
        NSString *urlPath = [request.URL.absoluteString substringFromIndex:[self.zw_option.hrefPrefix length]+1];
        NSArray *mixURLArray = [urlPath componentsSeparatedByString:[self encondingNSUTF8:self.zw_option.splitIndex]];
        //图片地址合集
        NSString *allImageURL = [mixURLArray firstObject];
        //当前实际点击图片的地址
        NSString *indexImageURL = [mixURLArray lastObject];
        if ([self judgeIndexImageUrl:indexImageURL withOption:self.zw_option]) {
            return NO;
        }
        //拆分后图片地址数组
        NSArray *allImageArray = [allImageURL componentsSeparatedByString:[self encondingNSUTF8:self.zw_option.splitURL]];
        //过滤不合规则的图片
        allImageArray = [self filterImageArray:allImageArray withFilterArray:self.zw_option];
        NSInteger index = [allImageArray indexOfObject:indexImageURL];
        if (self.blockHandlePreview) {
            self.blockHandlePreview(allImageArray, index);
            return YES;
        }
        ZWPreviewImageView *showView = [ZWPreviewImageView showImageWithArray:allImageArray withShowIndex:index];
        [showView showRootWindow];
        return YES;
    }
    return NO;
}
//判断当前点击图片地址是否需要被过滤
- (BOOL)judgeIndexImageUrl:(NSString *)indexURL withOption:(ZWHTMLOption *)option{
    for (NSString *filter in option.filterURL) {
        if ([indexURL containsString:filter]) {
            return YES;
        }
    }
    return NO;
}
#pragma mark - 过滤关键词
- (NSArray *)filterImageArray:(NSArray *)allImageArray withFilterArray:(ZWHTMLOption *)option{
    NSMutableArray *filterImageArray = [NSMutableArray array];
    for (NSString *imageURL in allImageArray) {
        BOOL isLegal = YES;
        for (NSString *filter in option.filterURL) {
            if ([imageURL containsString:filter]) {
                isLegal = NO;
                break;
            }
        }
        if (isLegal) {
            [filterImageArray addObject:imageURL];
        }
    }
    return filterImageArray;
}
- (NSString *)encondingNSUTF8:(NSString *)string{
    NSCharacterSet *character = [NSCharacterSet URLQueryAllowedCharacterSet];
    return [string stringByAddingPercentEncodingWithAllowedCharacters:character];
}
+ (NSString *)configPreviewJS:(ZWHTMLOption *)option{
    if (option.zwPreviewJS.length) {
        return option.zwPreviewJS;
    }
    NSBundle *bundle = [NSBundle bundleForClass:[ZWHTMLSDK class]];
    NSURL *url = [bundle URLForResource:@"ZWHTMLJS" withExtension:@"bundle"];
    NSBundle *jsBundle = [NSBundle bundleWithURL:url];
    
    NSString *filePath = [jsBundle pathForResource:@"zwPreview" ofType:@".js"];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSData *data = [fm contentsAtPath:filePath];
    NSString *jsStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //替换自定义关键词
    jsStr = [jsStr stringByReplacingOccurrencesOfString:OPTION_DefaultCoreJS withString:option.getAllImageCoreJS];
    jsStr = [jsStr stringByReplacingOccurrencesOfString:OPTION_SplitURL withString:option.splitURL];
    jsStr = [jsStr stringByReplacingOccurrencesOfString:OPTION_SplitIndex withString:option.splitIndex];
    jsStr = [jsStr stringByReplacingOccurrencesOfString:OPTION_HrefPrefix withString:option.hrefPrefix];
    return jsStr;
}
-(void)setZw_option:(ZWHTMLOption *)zw_option{
    _zw_option = zw_option;
}
@end
