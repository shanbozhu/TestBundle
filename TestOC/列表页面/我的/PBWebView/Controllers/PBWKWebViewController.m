//
//  PBWKWebViewController.m
//  TestOC
//
//  Created by DaMaiIOS on 2017/12/30.
//  Copyright © 2017年 DaMaiIOS. All rights reserved.
//

#import "PBWKWebViewController.h"
#import <WebKit/WebKit.h>

/**
 jsCalloc js端语句如下:
 var nativeDetailUrl = 'damai://V1/ProjectPage?id=' + id;
 window.webkit.messageHandlers.openPage.postMessage(nativeDetailUrl);
 */

@interface PBWKWebViewController ()<WKNavigationDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) WKWebViewConfiguration *configuration;
@property (nonatomic, weak) WKWebView *webView;

@end

@implementation PBWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
    self.configuration = configuration;
    
    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) configuration:configuration];
    self.webView = webView;
    [self.view addSubview:webView];
    webView.navigationDelegate = self;
    
    {
        NSString *jsonStr = @"Mozilla/5.0 (iPhone; CPU iPhone OS 11_2 like Mac OS X) AppleWebKit/604.4.7 (KHTML, like Gecko) Mobile/15C107damai DamaiApp iOS v6.3.0";
        NSLog(@"jsonStr = %@", jsonStr);
        [[NSUserDefaults standardUserDefaults]registerDefaults:@{@"UserAgent":jsonStr}];
        
        //ocCalljs
        [webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id _Nullable data, NSError * _Nullable error) {
            NSLog(@"data = %@, error = %@", data, error);
        }];
    }
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.urlStr]];
    [webView loadRequest:request];
}

// 实现jsCalloc的方法定义
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"message.name = %@, message.body = %@", message.name, message.body);
    
    if ([message.name isEqualToString:@"openPage"]) {
        UIViewController *vc = [[UIViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc animated:YES];
        vc.view.backgroundColor = [UIColor whiteColor];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //jsCalloc
    [self.configuration.userContentController addScriptMessageHandler:self name:@"openPage"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"openPage"];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    //ocCalljs
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        NSLog(@"data = %@, error = %@", data, error);
    }];
    
    //ocCalljs
    NSString *param0 = @"1";
    NSString *jsStr = [NSString stringWithFormat:@"realNameThenticate('%@')", param0];
    [webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        NSLog(@"data = %@, error = %@", data, error);
    }];
}

- (void)dealloc {
    NSLog(@"PBWKWebViewController对象被释放了");
}

@end
