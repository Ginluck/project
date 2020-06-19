
//
//  UIUtils.h
//  JiFuYiQianBao
//
//  Created by cocoa on 15/2/11.
//  Copyright (c) 2015年 了凡. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Singleton.h"

typedef void(^CheckVersionInfo)(id result);


@interface UIUtils : NSObject

//单例
single_interface(UIUtils)

/**
 *  判断回调url是否成功
 *
 *  @param urlStr 回调url
 *
 *  @return 判断结果
 */
+ (BOOL)chargeSuccessWithURL:(NSURL *)url;

+ (NSMutableDictionary *)groupByTimeWithData:(NSMutableArray *)data OldDictionary:(NSMutableDictionary *)oldDic;

+ (NSMutableArray *)groupKeysByTimeWithData:(NSMutableArray *)data OldKeys:(NSMutableArray *)oldKeys;

/**
 *  用户名加密
 *
 *  @param userName 用户名
 *
 *  @return 加密后的用户名
 */
+ (NSString *)securtyUserName:(NSString *)userName;
+ (BOOL) IsIdentityCard:(NSString *)IDCardNumber;

/**
 *  银行卡加密
 *
 *  @param bankCode 银行卡号
 *
 *  @return 加密后的卡号
 */
+ (NSString *)securtyBankCode:(NSString *)bankCode;

+ (NSString *)generateWithLength:(int)len;

/**
 *  生成随机验证码
 *
 *  @param len    验证码长度
 *  @param buffer 接收的指针
 */
void generate(int len,char* buffer);

/**
 *  接口时间字符转成app需要的时间字符串
 *
 *  @param dateStr 接口时间字符串
 *  @param formate 时间格式
 *
 *  @return app需要的时间字符串
 */
+ (NSString *)stringFromDateString:(NSString *)dateStr formate:(NSString *)formate ToFormate:(NSString *)tFormate;

/**
 *  将字符串格式化为Date对象
 *
 *  @param datestring 时间戳
 *  @param formate    时间格式
 *
 *  @return NSDate对象
 */
+ (NSDate *)dateFromString:(NSString *)datestring formate:(NSString *)formate;

/**
 *  将日期格式化为NSString对象
 *
 *  @param date    时间对象
 *  @param formate 时间格式
 *
 *  @return 时间字符串
 */
+ (NSString *)stringFromDate:(NSDate *)date formate:(NSString *)formate;

///**
// *  根据文本来计算高度
// *
// *  @param des  需要计算的文本
// *  @param font 文本的字体
// *  @param size 文本预定的大小
// *
// *  @return 文本的大小
// */
//+ (CGSize)getSizeWithLabel:(NSString *)des withFont:(UIFont *)font withSize:(CGSize)size;

/**
 *  数组本地化保存数据
 *
 *  @param aData    数据源
 *  @param fileName 保存文件名称
 */
+ (void)saveArray:(NSArray *)aData LocationFileName:(NSString *)fileName;

/**
 *  Documents中的文件路径
 *
 *  @param fileName 文件名字
 *
 *  @return 文件路径
 */
+ (NSString *)pathFromDocument:(NSString *)fileName;

/**
 *  从Documents中读取Plist文件
 *
 *  @param fileName Plist文件名字
 *
 *  @return 数组
 */
+ (NSArray *)readFromDocumentPlist:(NSString *)fileName;

/**
 *  请求的参数字典排序并加密
 *
 *  @param dic 参数字典
 *
 *  @return 加密后的字符串
 */
//+ (NSString *)compareParam:(NSDictionary *)dic;

/**
 *  MD5加密
 *
 *  @param string 原始字符串
 *
 *  @return MD5加密后的字符串
 */
+ (NSString *) md5HexDigest:(NSString *)string;

/**
 *  计算目录下面所有文件的大小
 *
 *  @param directory 目录名称
 *
 *  @return 目录文件大小
 */
+ (long long)countDirectorySize:(NSString *)directory;

/**
 *  正则判断用户名：请用字母、数字、下划线,至少6个字符
 *
 *  @param userName 用户名字符串
 *
 *  @return 是否正确
 */
+ (BOOL)isValidateUserName:(NSString *)userName;

/**
 *  正则判断密码：密码只能为 8 - 32 位数字，字母及常用符号组成
 *
 *  @param password 密码字符串
 *
 *  @return 是否正确
 */
+(BOOL)isValidatePassWord:(NSString *)password;

/**
 *  正则验证邮箱
 *
 *  @param email 邮箱地址
 *
 *  @return 是否正确
 */
+(BOOL)isValidateEmail:(NSString *)email;


/**
 *  描述：利用正则判断手机号格式是否正确
 *
 *  @param mobile 需要判断的手机号
 *
 *  @return 返回是否正确
 */
+ (BOOL) isValidateMobile:(NSString *)mobile;

/*
 *
 */
+(CGSize)getSizeWithMaxSize:(CGSize)maxSize WithFontSize:(int)fontSize str:(NSString *)str;

/**
 *  根据appId获取当前应用的版本信息
 *
 *  @return appid
 */
+ (void)getVersionInfoWithAppid:(int)appid infoResult:(CheckVersionInfo)block;

#pragma mark - 数据解析
// 产品数据解析
+ (NSMutableArray *)getGoodsModelFromArray:(NSArray *)data;

+(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;
/**
 * 实现圆头像
 *padding 圆形图像距离图像的边距
 **/
+(UIImage*)getEllipseImageWithImage:(UIImage*)originImage padding:(CGFloat)padding;

+ (NSString *)creatTimeWith:(NSString *)dateStr;
+ (NSString *)creatTimeWithTimeString:(NSString *)time dateFormat:(NSString *)format;
+ (NSString *)creatTimeWithTimeString:(NSString *)time dateFormat:(NSString *)format dateFomat:(NSString*)format2;
//阿拉伯数字转换成大写数字
+(NSString *)translationArabicNum:(NSInteger)arabicNum;
//十六进制的string转UIColor
+ (UIColor *) colorWithHexString: (NSString *)color;
//UIColor转16进制string
+ (NSString *) changeUIColorToRGB:(UIColor *)color;
//是否打开通讯录
+(void)CheckAddressBookAuthorization:(void (^)(bool isAuthorized))block;
#pragma mark 百度地图定位
//开启定位
- (void)startBaiduMap;
//关闭定位
- (void)stopBaiduMap;
//获取设备类型

+ (NSString *)iphoneType;
//获取当前时间
+(NSString*)getCurrentTimes;

+(NSDictionary *)getUrlHeadWithString:(NSString *)urlString;


+(NSString *)getHXtimeStr:(long long)timestamp;

@end
