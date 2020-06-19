//
//  NSDate+CommonDate.h
//  XinJiangTaxiProject
//
//  Created by apple on 2017/7/5.
//  Copyright © 2017年 HeXiulian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CommonDate)

/**
 将一个日期以一定的格式转成字符串
 @param format 格式
 @return 字符串时间
 */
- (NSString *)dateStringWithFormat:(NSString *)format;

/**
 * 将NSDate转换成年月日格式yyyy-MM-dd
 * @return NSString
 */
+(NSString *)get_yyyy_MM_dd_With_Date_Type:(NSDate *)date;

/**
 * 获取上一个月的日期
 * @return NSDate
 */
+(NSDate *)getLastMonthDateWithCalender:(NSDate *)date;

/**
 * 获取距离多少天前、后的日期
 * @return NSDate
 */
-(NSDate *)getDateWithDay:(NSInteger)day;

/**
 根据格式将一个字符串时间以一定的格式转为date
 @param format 格式
 @param dateString 字符串时间
 @return date对象
 */
+ (NSDate *)dateWithFormat:(NSString *)format dateString:(NSString *)dateString;

/**
 * 获取日期yyyy-MM-dd是几号
 * @param time yyyy-MM-dd
 * @return 几号字符串
 */
+ (NSString *)getDayWithString:(NSString *)time;

/**
 * 更具日期获取今天星期几
 * @param time yyyy-MM-dd
 * * @return 星期序号
 */
+ (NSInteger )getWeekNumberWithDateString:(NSString *)time;

/**
 * 获取日期yyyy-MM-dd是几号
 * @param time yyyy-MM-dd
 * @return xx月xx日
 */
+ (NSString *)getMonthAndDayWithString:(NSString *)time;


/**
 获取时间戳

 @return <#return value description#>
 */
- (NSInteger)getTimeStamp;

/**
 转毫秒

 @return <#return value description#>
 */
-(long long)getDateTimeTOMilliSeconds;

/**
 * 根据时间字符串获取两个时间间隔几天
 */
+ (NSString *)getBetweenDayTime:(NSString *)firstTime withLastTime:(NSString *)twoTime;

/**
 * 更具日期获取今天星期几
 * @param time yyyy-MM-dd
 * * @return 星期
 */
+ (NSString  *)getWeekStringWithDateString:(NSString *)time;

//获取年
- (NSUInteger)getYear;

//获取月
-(NSUInteger)getMonth;

//获取日
- (NSUInteger)getDay;

//获取小时
- (NSInteger)getHour;

//该月的第一天
- (NSDate *)beginningOfMonth;

//该月的最后一天
- (NSDate *)endOfMonth;

/// 是否是今天
- (BOOL)isToday;

/**
 根据日期获取周几
 @param inputDate date
 @return 周几
 */
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate ;

/**
 获取指定日期几个月后的时间

 @param dateStr 日期
 @param month 月
 @return 日期
 */
+ (NSDate *)getDateWithStrDate:(NSString *)dateStr toMonthLate:(NSInteger)month;


/**
 获取指定日期多少天后的时间
 @param day 月
 @return 日期
 */
- (NSDate *)getDateWithDayLate:(NSInteger)day;



+(NSString*)getCurrentTimes;


/**
比较两个时间

 @param stary 开始时间
 @param end 结束时间
 @return 两个时间的大小
 */
+ (BOOL)compareDate:(NSDate*)stary withDate:(NSDate*)end;
@end
