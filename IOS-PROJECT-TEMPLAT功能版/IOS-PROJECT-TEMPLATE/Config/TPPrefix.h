//
//  MKPrifix.pch
//  MK
//
//  Created by 周洋 on 2019/3/8.
//  Copyright © 2019年 周洋. All rights reserved.
//

#ifndef TPPrifix_pch
#define TPPrifix_pch

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <YYModel.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "UserManager.h"
#import "UserModel.h"
#import "APIString.h"
#import <Hyphenate/Hyphenate.h>
#import "EMHeaders.h"
//macro 宏
#import "TPColor.h"
#import "TPDevice.h"
#import "TPFont.h"
#import "TPBridging.h"
#import "TPConfigkey.h"

//height
#define kNavagationBarH (IS_IPhoneX_All ? 88 : 64)
#define kTabBarH (IS_IPhoneX_All ? 83 : 49)
#define kBottomLayout (IS_IPhoneX_All ? 34 : 0)
#define kTopLayout (IS_IPhoneX_All ? 44 : 20)

#define DLog( s, ... ) NSLog( @"< %@:(%d) > %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#define NavigationBar_BGCOLOR COLOR(227, 53, 52, 1)
//分割线颜色
#define DIVIDELINECOLOR COLOR_HEX(0xebf0f2)
//缩放比例
#define Kscale            [UIScreen mainScreen].bounds.size.width / 414

//category 扩展
#import "UIView+Layout.h"
#import "UIImage+GradiusColor.h"
#import "UIImageView+WebCache.h"
#import "NSString+Utilites.h"
#import "NSString+SizeOfString.h"
#import "UIButton+layout.h"
#import "UILabel+layout.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import <MJRefresh.h>
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "UIUtils.h"
#import "UIButton+WebCache.h"
#import "Masonry.h"
#import "RequestHelp.h"
#import "ViewControllerManager.h"
#endif /* TPPrifix_pch */
