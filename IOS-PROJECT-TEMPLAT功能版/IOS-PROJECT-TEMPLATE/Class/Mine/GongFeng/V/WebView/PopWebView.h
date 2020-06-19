//
//  PopWebView.h
//  路丫租车-三期
//
//  Created by Apple on 2018/12/10.
//  Copyright © 2018 ginluck. All rights reserved.
//

#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef void (^ReloadBlock)(void);
@interface PopWebView : UIView
@property(nonatomic,copy)ReloadBlock reloadBlock;
@property(nonatomic,copy)NSString *htmlString;
@property(nonatomic,strong)WKWebView *webView;
@end

NS_ASSUME_NONNULL_END
