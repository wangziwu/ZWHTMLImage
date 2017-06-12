//
//  WKWebViewViewController.m
//  ZWHTMLImageDemo
//
//  Created by 王子武 on 2017/6/7.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

#import "WKWebViewViewController.h"
#import <WebKit/WebKit.h>
#import "ZWHTMLSDK.h"
@interface WKWebViewViewController ()<WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
/** */
@property (nonatomic, strong) ZWHTMLSDK *htmlSDK;
@end

@implementation WKWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configWebView];
}
- (void)configWebView{
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    self.webView.navigationDelegate = self;
    NSURL *url = [NSURL URLWithString:@"http://www.jianshu.com/p/4fb95a281787"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    self.htmlSDK = [ZWHTMLSDK zw_loadStandardBridgeJSWebview:webView];
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
    [self.htmlSDK zw_handlePreviewImageRequest:navigationAction.request];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
