//
//  PopWebView.m
//  路丫租车-三期
//
//  Created by Apple on 2018/12/10.
//  Copyright © 2018 ginluck. All rights reserved.
//

#import "PopWebView.h"
#import "NJKWebViewProgress.h"
@interface PopWebView ()<WKUIDelegate ,WKNavigationDelegate>

@end

@implementation PopWebView
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
    WKWebView *webview =[[WKWebView alloc]initWithFrame:self.bounds];
//    webview.userInteractionEnabled = NO;
        webview.UIDelegate=self;
        webview.navigationDelegate=self;
    [self addSubview:webview];
    self.webView = webview;
        
    }
    return self;
}

-(void)setHtmlString:(NSString *)htmlString
{
//    NSString *headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>";
//    [self.webView loadHTMLString:[headerString stringByAppendingString:htmlString] baseURL:nil];
   // [MBProgressHUD showMessage:@"" toView:self];
    
    ShowMessage(@"");
[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:htmlString]]];
//    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
//    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
//    wkWebConfig.userContentController = wkUController;
//    //自适应屏幕的宽度js
//    NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
//    WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//    //添加js调用
//    [wkUController addUserScript:wkUserScript];
//    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1) configuration:wkWebConfig];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    //[MBProgressHUD hideHUDForView:self];
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
