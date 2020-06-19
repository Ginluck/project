//
//  UnitMacro.h
//  XinJiangTaxiProject
//
//  Created by apple on 2017/7/4.
//  Copyright © 2017年 HeXiulian. All rights reserved.
//

#ifndef UnitMacro_h
#define UnitMacro_h

#define kUserDefaults   [NSUserDefaults standardUserDefaults]
#define GetUserDefaults(key) [kUserDefaults objectForKey:key]
#define NetworkStatusKey @"networkStatus"

/**
 判断字段时候为空的情况
 @param x 字段名称
 */
#define SET_STRING(x,normalMsg) ([(x) isEqual:[NSNull null]]||(x)==nil)? normalMsg:x

#define USER_NAME [[NSUserDefaults standardUserDefaults] stringForKey:@"userName"]


#endif /* UnitMacro_h */
