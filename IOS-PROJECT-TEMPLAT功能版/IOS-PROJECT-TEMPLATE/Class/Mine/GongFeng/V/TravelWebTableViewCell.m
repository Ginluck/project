//
//  TravelWebTableViewCell.m
//  路丫租车-三期
//
//  Created by Apple on 2018/10/15.
//  Copyright © 2018年 ginluck. All rights reserved.
//

#import "TravelWebTableViewCell.h"
#import <WebKit/WebKit.h>
#import "NJKWebViewProgress.h"
@interface TravelWebTableViewCell ()<WKNavigationDelegate,WKUIDelegate>
{
    NJKWebViewProgress *_progressProxy;
    
}
@property (nonatomic , assign)BOOL isLoading;
@property (strong, nonatomic) WKWebView *WebView;

@end
static CGFloat staticheight = 0;

@implementation TravelWebTableViewCell
+(CGFloat)cellHeight
{
    return staticheight;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    if (staticheight !=0) {
        staticheight=0;
    }
    self.isLoading = NO;
    _WebView =[[WKWebView alloc]initWithFrame:CGRectMake(0, 16, Screen_Width-32, 1)];
    self.WebView.userInteractionEnabled = NO;
    [self.WebOutSideView addSubview:self.WebView];
    // Initialization code
}
-(void)setHtmlString:(NSString *)htmlString
{
    
    if (self.isLoading == NO && htmlString.length > 0)
    {
        self.isLoading = YES;
        _htmlString = htmlString;
        
        self.WebView.UIDelegate = self;
        self.WebView.navigationDelegate = self;
        //        NSString *htmls = [NSString stringWithFormat:@"<html> \n"
        //                           "<head> \n"
        //                           "<style type=\"text/css\"> \n"
        //                           "body {font-size:0.875rem;width:'375px';height:'auto'}\n"
        //                           "</style> \n"
        //                           "</head> \n"
        //                           "<body>"
        //                           "<script type='text/javascript'>"
        //                           "window.onload = function(){\n"
        //                           "var $img = document.getElementsByTagName('img');\n"
        //                           "for(var p in  $img){\n"
        //                           " $img[p].style.width = '100%%';\n"
        //                           "$img[p].style.height ='auto'\n"
        //                           "}\n"
        //                           "}"
        //                           "</script>%@"
        //                           "</body>"
        //                           "</html>",htmlString];
        //
        //        NSString *myStr = [NSString stringWithFormat:@"<head><style>img{max-width:%f !important;}</style></head>",SCREEN_WIDTH];
        //        NSString *str = [NSString stringWithFormat:@"%@%@",myStr,htmlString];
        
        //        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:htmlString]]];
        
        
//        NSString *newStr = [NSString stringWithFormat:@"<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'><meta name='apple-mobile-web-app-capable' content='yes'><meta name='apple-mobile-web-app-status-bar-style' content='black'><meta name='format-detection' content='telephone=no'><style type='text/css'>img{width:%fpx}</style>%@", Screen_Width - 32, htmlString];
        
       [self.WebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:htmlString]]];
        //        [self setupAutoHeightWithBottomView:self.webView bottomMargin:0];
        
    }
    
    
}
// 页面加载完成之后调用 此方法会调用多次
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    __block CGFloat webViewHeight;
    MJWeakSelf
    //获取内容实际高度（像素）@"document.getElementById(\"content\").offsetHeight;"
    [webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable result,NSError * _Nullable error) {
        // 此处js字符串采用scrollHeight而不是offsetHeight是因为后者并获取不到高度，看参考资料说是对于加载html字符串的情况下使用后者可以(@"document.getElementById(\"content\").offsetHeight;")，但如果是和我一样直接加载原站内容使用前者更合适
        //获取页面高度，并重置webview的frame
        webViewHeight = [result doubleValue];
        weakSelf.WebView.frame = CGRectMake(0, 0, Screen_Width-32-16, webViewHeight);
        staticheight = webViewHeight;
        if (weakSelf.reloadBlock)
        {
            weakSelf.reloadBlock();
        }
        //        weakSelf.webView.sd_layout
        //        .leftSpaceToView(self.contentView, 10)
        //        .rightSpaceToView(self.contentView, 10)
        //        .topSpaceToView(self.contentView, 0)
        //        .heightIs(staticheight);
        //        [weakSelf setupAutoHeightWithBottomView:self.webView bottomMargin:0];
//        NSLog(@"%f",staticheight);
    }];
    
    NSLog(@"结束加载");
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        
        NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
        
        completionHandler(NSURLSessionAuthChallengeUseCredential,card);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
