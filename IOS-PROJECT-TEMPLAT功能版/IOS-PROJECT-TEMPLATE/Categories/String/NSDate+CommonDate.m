//
//  NSDate+CommonDate.m
//  XinJiangTaxiProject
//
//  Created by apple on 2017/7/5.
//  Copyright © 2017年 HeXiulian. All rights reserved.
//

#import "NSDate+CommonDate.h"

@implementation NSDate (CommonDate)

/**
 将一个日期以一定的格式转成字符串
 @param format 格式
 @return 字符串时间
 */
- (NSString *)dateStringWithFormat:(NSString *)format{
    
    NSDateFormatter *dateF = [[NSDateFormatter alloc] init];
    dateF.dateFormat = format;
    
    return [dateF stringFromDate:self];
}

/**
 * 将NSDate转换成年月日格式yyyy-MM-dd
 * @return NSString
 */
+(NSString *)get_yyyy_MM_dd_With_Date_Type:(NSDate *)date {

    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString * reusltDate = [formatter stringFromDate:date];
    
    return reusltDate;
}

/**
 * 获取上一个月的日期
 * @return NSDate
 */
+(NSDate *)getLastMonthDateWithCalender:(NSDate *)date {

    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    [comps setYear:0];
    [comps setMonth:-1];
    [comps setDay:0];
    
    return [calendar dateByAddingComponents:comps toDate:date options:0];
}
/**
 * 获取下一个月的日期
 * @return NSDate
 */
+(NSDate *)getNextMonthDateWithCalender:(NSDate *)date {
    
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    [comps setYear:0];
    [comps setMonth:1];
    [comps setDay:0];
    
    return [calendar dateByAddingComponents:comps toDate:date options:0];
}

/**
 * 获取距离多少天前、后的日期
 * @return NSDate
 */
-(NSDate *)getDateWithDay:(NSInteger)day{
    
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    [comps setYear:0];
    [comps setMonth:0];
    [comps setDay:day];
    
    return [calendar dateByAddingComponents:comps toDate:self options:0];
}

/**
 根据格式将一个字符串时间以一定的格式转为date
 @param format 格式
 @param dateString 字符串时间
 @return date对象
 */
+ (NSDate *)dateWithFormat:(NSString *)format dateString:(NSString *)dateString{
    NSDateFormatter *dateF = [[NSDateFormatter alloc] init];
    dateF.dateFormat = format;
    return  [dateF dateFromString:dateString];
}

/**
 * 获取日期yyyy-MM-dd是几号
 * @param time yyyy-MM-dd
 * @return 几号字符串
 */
+ (NSString *)getDayWithString:(NSString *)time {

    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * normalDate = [formatter dateFromString:time];
    
    NSString *str1 = [self get_yyyy_MM_dd_With_Date_Type:normalDate];
    NSString *str2 = [self get_yyyy_MM_dd_With_Date_Type:[NSDate date]];
    
    if ([str1 isEqualToString:str2]) {
        return @"今天";
    }
    
    [formatter setDateFormat:@"dd"];
    NSString * reusltDate = [formatter stringFromDate:normalDate];
    return reusltDate;
}

/**
 获取指定日期几个月后的时间
 
 @param dateStr 日期
 @param month 月
 @return 日期
 */
+ (NSDate *)getDateWithStrDate:(NSString *)dateStr toMonthLate:(NSInteger)month{
    NSDate *date = [NSDate dateWithFormat:@"yyyy-MM-dd HH-mm" dateString:dateStr];
    
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    [comps setYear:0];
    [comps setMonth:month];
    [comps setDay:0];
    date = [calendar dateByAddingComponents:comps toDate:date options:0];
    
    return date;
    
}

/**
 获取指定日期多少天后的时间
 @param day 月
 @return 日期
 */
- (NSDate *)getDateWithDayLate:(NSInteger)day{
    
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    [comps setYear:0];
    [comps setMonth:0];
    [comps setDay:day];
    NSDate  *date = [calendar dateByAddingComponents:comps toDate:self options:0];
    
    return date;
}

/**
 * 更具日期获取今天星期几
 * @param time yyyy-MM-dd
 * * @return 星期序号
 */
+ (NSString  *)getWeekStringWithDateString:(NSString *)time {
    
    //获取date
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * date = [formatter dateFromString:time];
    
    //获取星期(zhongzi)
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    NSString * week = [weekdays objectAtIndex:theComponents.weekday];
    return week;
}
/**
 * 更具日期获取今天星期几
 * @param time yyyy-MM-dd
 * * @return 星期序号
 */
+ (NSInteger )getWeekNumberWithDateString:(NSString *)time {

    //获取date
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * date = [formatter dateFromString:time];
    
    //获取星期(zhongzi)
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    NSString * week = [weekdays objectAtIndex:theComponents.weekday];
    
    //转换星期为序号
    NSInteger weekNum = 0;
    if ([week isEqualToString:@"周一"]) {
        weekNum = 0;
    } else if ([week isEqualToString:@"周二"]) {
        weekNum = 1;
    } else if ([week isEqualToString:@"周三"]) {
        weekNum = 2;
    } else if ([week isEqualToString:@"周四"]) {
        weekNum = 3;
    } else if ([week isEqualToString:@"周五"]) {
        weekNum = 4;
    } else if ([week isEqualToString:@"周六"]) {
        weekNum = 5;
    } else if ([week isEqualToString:@"周日"]) {
        weekNum = 6;
    }
    
    return weekNum;
}

/**
 * 获取日期yyyy-MM-dd是几号
 * @param time yyyy-MM-dd
 * @return xx月xx日
 */
+ (NSString *)getMonthAndDayWithString:(NSString *)time {

    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * normalDate = [formatter dateFromString:time];
    
    [formatter setDateFormat:@"MM月dd日"];
    NSString * reusltDate = [formatter stringFromDate:normalDate];
    return reusltDate;
}


- (NSInteger)getTimeStamp{
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: self];
    
    interval += 30 * 24 * 60 * 60;
    interval -= 8*60*60;
    
    return interval;
}

-(long long)getDateTimeTOMilliSeconds{
    
    NSTimeInterval interval = [self timeIntervalSince1970];
    
    long long totalMilliseconds = interval*1000 ;
    
    return totalMilliseconds;
}



+ (NSString *)getBetweenDayTime:(NSString *)firstTime withLastTime:(NSString *)twoTime {
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter
                                        alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
//    [inputFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *startD =[inputFormatter
                     dateFromString:firstTime];
    NSDate *endD = [inputFormatter
                    dateFromString:twoTime];
    
    /*
    // 当前日历
    NSCalendar *calendar = [NSCalendar
                            currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit =
    NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay;
    // 对比时间差
    NSDateComponents *dateCom = [calendar
                                 components:unit fromDate:endD
                                 toDate:startD options:0];
    
    return [NSString stringWithFormat:@"%ld",dateCom.day];
     */
    
    NSTimeInterval time = [endD timeIntervalSinceDate:startD];
    
    int days = ceil((time) / (3600*24.0));
    return [NSString stringWithFormat:@"%d",days<1?1:days];
}

//获取年
- (NSUInteger)getYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:self];
    return [dayComponents year];
}

//获取月
- (NSUInteger)getMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:self];
    return [dayComponents month];
}

//获取日
- (NSUInteger)getDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:self];
    return [dayComponents day];
}

//获取小时
- (NSInteger)getHour {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour|NSCalendarUnitMinute;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    NSInteger hour = [components hour];
    return hour;
}

//返回day天后的日期(若day为负数,则为|day|天前的日期)
- (NSDate *)dateAfterDay:(int)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get the weekday component of the current date
    // NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    // to get the end of week for a particular date, add (7 - weekday) days
    [componentsToAdd setDay:day];
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    
    return dateAfterDay;
}



+(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

//month个月后的日期
- (NSDate *)dateAfterMonth:(int)month
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    
    return dateAfterMonth;
}

//返回该月的第一天
- (NSDate *)beginningOfMonth {
    return [self dateAfterDay:(int)(-[self getDay] + 1)];
}

//该月的最后一天
- (NSDate *)endOfMonth {
    return [[[self beginningOfMonth] dateAfterMonth:1] dateAfterDay:-1];
}


+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    if ([inputDate isToday]) {
        return @"今天";
    }
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
}

- (BOOL)isToday {
    return [self zh_isSameDay:[NSDate date]];
}

- (BOOL)zh_isSameDay:(NSDate *)anotherDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:self];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:anotherDate];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]
            && [components1 day] == [components2 day]);
}


+ (BOOL)compareDate:(NSDate*)stary withDate:(NSDate*)end
{
    NSComparisonResult result = [stary compare: end];
    if (result==NSOrderedSame)
    {
        //相等
        return NO;
    }else if (result ==NSOrderedAscending)
    {
        //结束时间大于开始时间
        return YES;
    }else if (result==NSOrderedDescending)
    {
        //结束时间小于开始时间
        return NO;
    }
    return NO;
}
@end
