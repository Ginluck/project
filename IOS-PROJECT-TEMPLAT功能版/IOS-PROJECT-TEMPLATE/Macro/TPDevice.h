//
//  TPDevice.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2019/7/2.
//  Copyright © 2019年 梦境网络. All rights reserved.
//

#ifndef TPDevice_h
#define TPDevice_h
//获取屏幕宽高
#define Screen_Width ([UIScreen mainScreen].bounds.size.width)
#define Screen_Height ([UIScreen mainScreen].bounds.size.height)


#define Is_IPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define Is_IPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//判断iPHoneXr

#define Is_IPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !Is_IPad : NO)

//判断iPHoneX、iPHoneXs
#define Is_IPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !Is_IPad : NO)
#define Is_IPhone_XS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !Is_IPad : NO)

//判断iPhoneXs Max
#define Is_IPhone_XS_MAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !Is_IPad : NO)

#define IS_IPhoneX_All (Is_IPhoneXR || Is_IPhoneX || Is_IPhone_XS || Is_IPhone_XS_MAX)
//#define IS_IPhoneX_All ([UIScreen mainScreen].bounds.size.height == 812 || [UIScreen mainScreen].bounds.size.height == 896)

//height
#define K_NaviHeight (IS_IPhoneX_All ? 88 : 64)
#define K_TabbarHeight (IS_IPhoneX_All ? 83 : 49)
#define K_BottomHeight (IS_IPhoneX_All ? 34 : 0)
#define K_StatusBarHeight (IS_IPhoneX_All ? 44 : 20)

/*
//padding
#define K_Padding_LeftPadding 15
#define K_Padding_Home_LeftPadding 25
 */

//基于iphone6 的屏幕宽度比
#define K_iPhone6BreadthWidth [UIScreen mainScreen].bounds.size.width/375
#define K_iPhone6BreadthHeight [UIScreen mainScreen].bounds.size.height/667
// 宽度适配
#define KScaleWidth(width) ( (width) * K_iPhone6BreadthWidth)
// 高度适配
#define KScaleHeight(height) ((height)*K_iPhone6BreadthHeight)

//底部按钮高度


//Iphone Type
#define K_IS_IPHONE_4     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) : NO)

#define K_IS_IPHONE_4S     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define K_IS_IPHONE_5      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define K_IS_IPHONE_6      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
//1125x2001 6+是放大模式下的分辨率
#define K_IS_IPHONE_6_PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO) || ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) : NO)

//获取当前系统版本
#define K_ios12_0_ ([[UIDevice currentDevice].systemVersion floatValue] >= 12.0)
#define K_ios11_0_ ([[UIDevice currentDevice].systemVersion floatValue] >= 11.0)
#define K_ios10_0_ ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0)
#define K_ios9_0_ ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)
#define K_ios8_0_ ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)

//设备型号
#define K_IS_IPAD          [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
#define K_IS_IPHONE        [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone





//无图标的条目高度
#define NO_ICON_CELLHEIGHT 45
//有图标的条目高度
#define ICON_CELLHEIGHT 50
#endif /* TPDevice_h */
