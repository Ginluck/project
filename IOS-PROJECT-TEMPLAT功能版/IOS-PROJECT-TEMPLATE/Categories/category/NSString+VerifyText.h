//
//  NSString+VerifyText.h
//  XinJiangTaxiProject
//
//  Created by apple on 2017/7/7.
//  Copyright © 2017年 HeXiulian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (VerifyText)

/**
 是否工商税号
 
 @return YES
 */
- (BOOL)isValidTaxNo;

/**
 是否纯汉字

 @return YES
 */
- (BOOL)isValidChinese;

/**
 包含数字，字母特殊字符
 @param length 长度
 @return 结果
 */
- (BOOL)isNoChinessMin:(int)length  max:(int)maxLength;

- (BOOL)isEmpty;

/**
 座机号码验证
 @return 结果
 */
- (BOOL)validateTelphone;
/**
 邮编验证
 @return 结果
 */
- (BOOL)validateZipCode;

/**
  判断银行卡号是否合法

 @return <#return value description#>
 */
#pragma mark

-(BOOL)isBankCard;


/**
 验证身份证格式（只是格式正确）

 @return 结果
 */
- (BOOL)judgeIdentityStringValid;

/**
 身份证号(完全正确）
 
 @return 结果
 */
- (BOOL)checkIsself;

/**
 *  正则表达式验证手机号
 *  @return 结果
 */
- (BOOL)validateMobile;

/**
 邮箱验证

 @return 结果
 */
- (BOOL)validateEmail;
/**
 *  计算文本高度方法
 *
 *  @param w        要显示的控件的宽度
 *  @param fontsize 控件显示文本的字体大小
 *
 *  @return 返回计算的文本占用位置的大小（含宽，高）
 */
-(CGSize)calculationStringSizeWithWidth:(CGFloat)w fontSize:(CGFloat)fontsize;

//字典转json格式字符串：
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

@end
