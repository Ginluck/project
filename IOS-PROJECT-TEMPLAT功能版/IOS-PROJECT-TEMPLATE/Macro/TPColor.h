//
//  TPColor.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2019/7/2.
//  Copyright © 2019年 梦境网络. All rights reserved.
//

#ifndef TPColor_h
#define TPColor_h


//传入rgb值确定颜色
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
//传入16进制数值确定颜色
#define COLOR_HEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


/*
 常用文字，背景，线条颜色设置根据不同项目自定义补充
 */
#define K_Prokect_MainColor COLOR(94, 17, 35, 1)      //主题颜色

#define k_Project_TabbarTextColor COLOR_HEX(0x666666) //底部导航栏文字默认颜色
#define kBGViewCOLOR COLOR_HEX(0xf5f5f5)
#define Gray_line_COLOR COLOR_HEX(0xededed)

#define K_PROJECT_GARYTEXTCOLOR COLOR_HEX(0x929292)


#endif /* TPColor_h */
