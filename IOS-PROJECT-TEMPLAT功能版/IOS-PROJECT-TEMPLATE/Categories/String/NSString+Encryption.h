//
//  NSString+Encryption.h
//  XinJiangTaxiProject
//
//  Created by he on 2017/7/8.
//  Copyright © 2017年 HeXiulian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encryption)


/**
 加密

 @param key yyyy-MM-dd HH:mm:ss
 @return 加密串
 */
- (NSString *)encryptAESWithkey:(NSString *)key;    //加密

/**
 解密

 @param key yyyy-MM-dd HH:mm:ss
 @return 解密后的字符串
 */
- (NSString *)decryptAESWithkey:(NSString *)key;   //解密

/**
 * SHA_256加密
 */
- (NSString*)SHA_256;


@end
