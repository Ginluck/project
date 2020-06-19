//
//  NSObject+SystemInfo.h
//  XinJiangTaxiProject
//
//  Created by apple on 2017/7/5.
//  Copyright © 2017年 HeXiulian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SystemInfo)

/**
 获取手机类型

 @return 手机类型:iPhone 6s plus
 */
- (NSString *)getPhoneType;

/**
 获取app版本
 
 @return app版本:1.0.2
 */
- (NSString *)getAppVersion;

/**
 获取系统时间

 @return 系统时间 :2017-07-05 13:30:00
 */
- (NSString *)getSystemDate;

/**
 获取手机操作系统

 @return 手机操作系统：iOS
 */
- (NSString *)getOSType;


/**
 获取手机系统版本

 @return 手机系统版本：9.1
 */
- (NSString *)getSystemVersion;


/**
 获取App下载渠道

 @return App下载渠道
 */
- (NSString *)getAppLoadChannelID;

/**
获取设备的UUID

 @return 设备的UUID
 */
- (NSString *)getDeviceUUID;


/**
 获取设备的分辨率

 @return 设备的分辨率
 */
- (NSString *)getDevicePixels;

- (NSString *)getImageName;
///对象转字典
- (NSMutableDictionary *)createDictionayFromModelProperties;

@end






