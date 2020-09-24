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
    
    // 请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[self.urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    {
        // ocCalljs 原始UA
        [webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id _Nullable userAgent, NSError * _Nullable error) {
            NSLog(@"userAgent = %@", userAgent);
            
            NSString *jsonStr = @"DamaiApp WKWebView iOS v6.3.0";
            jsonStr = [userAgent stringByAppendingFormat:@" %@", jsonStr];
            
            // 存储UA
            [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent" : jsonStr}];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }];
        
        // 对于WebView而言,在发起网络请求时,系统会自动设置UA,无需手动调用 [request setValue:jsonStr forHTTPHeaderField:@"User-Agent"];
    }
    
    {
        // 存储Cookie
        NSMutableDictionary *oneCookieDict = [NSMutableDictionary dictionary]; // oneCookie
        oneCookieDict[NSHTTPCookieDomain] = @".damai.cn";
        oneCookieDict[NSHTTPCookiePath] = @"/";
        oneCookieDict[NSHTTPCookieName] = @"ma_maitian_client";
        oneCookieDict[NSHTTPCookieValue] = @"11";
        NSHTTPCookie *oneCookie = [NSHTTPCookie cookieWithProperties:oneCookieDict];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:oneCookie];
        
        NSMutableDictionary *twoCookieDict = [NSMutableDictionary dictionary]; // twoCookie
        twoCookieDict[NSHTTPCookieDomain] = @".damai.cn";
        twoCookieDict[NSHTTPCookiePath] = @"/";
        twoCookieDict[NSHTTPCookieName] = @"damai.cn_maitian_user";
        twoCookieDict[NSHTTPCookieValue] = @"WKWebView";
        NSHTTPCookie *twoCookie = [NSHTTPCookie cookieWithProperties:twoCookieDict];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:twoCookie];
        
        // 拼接Cookie,然后设置Cookie
        NSMutableString *cookieString = [NSMutableString string];
        for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
            if ([cookie.domain isEqualToString:@".damai.cn"]) { // 针对特定域名,拼接特定cookie
                [cookieString appendString:[NSString stringWithFormat:@"%@=%@; ", cookie.name, cookie.value]];
            }
        }
        if ([cookieString rangeOfString:@";"].location != NSNotFound) {
            [cookieString deleteCharactersInRange:NSMakeRange(cookieString.length - 2, 2)];
        }
        
        [request setValue:cookieString forHTTPHeaderField:@"Cookie"];
    }
    
    NSLog(@"WKWebView: allHTTPHeaderFields = %@", request.allHTTPHeaderFields);
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
    
    // jsCalloc
    [self.configuration.userContentController addScriptMessageHandler:self name:@"openPage"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"openPage"];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    // ocCalljs
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        NSLog(@"data = %@, error = %@", data, error);
    }];
    
    // ocCalljs
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
