//
//  ViewControllerManager.h
//  XinJiangTaxiProject
//
//  Created by he on 2017/7/11.
//  Copyright © 2017年 HeXiulian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewControllerManager : NSObject

//+ (instancetype)shareInstance;

+(void)showLoginViewController;

+ (void)showMainViewController;

+ (void)showIndexViewController;

@end
