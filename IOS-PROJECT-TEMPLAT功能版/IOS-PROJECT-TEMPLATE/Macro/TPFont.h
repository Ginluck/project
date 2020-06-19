//
//  TPFont.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2019/7/2.
//  Copyright © 2019年 梦境网络. All rights reserved.
//

#ifndef TPFont_h
#define TPFont_h
//主要字体名称
#define MainFontName @"Helvetica"
//数字字体、英文字体
#define MainNumberFontName @"Helvetica"

/*
  项目中某些特定字体大小均需通过该方法来设定，方法一是普通文字大小设定字号，方法二是加粗文字大小设定字号
 */
#define MKFont(x) [UIFont fontWithName:MainFontName size:x]
#define MKBoldFont(fontSize) [UIFont boldSystemFontOfSize:fontSize]



#define K_TEXTFIELD_TITLE_FONT MKFont(14)
#define K_TEXTFIELD_CONTENT_FONT MKFont(13)
#define K_BUTTON_TITLE_FONT MKFont(18)
#define k_nCELL_TITLE_FONT MKFont(16)

#define k_hCELL_FIRSTTITLE_FONT MKFont(16)
#define k_hCELL_SECONDTITLE_FONT MKFont(14)
/*
 通用文字大小需单独设置工程共享的字号大小
 */

#endif /* TPFont_h */
