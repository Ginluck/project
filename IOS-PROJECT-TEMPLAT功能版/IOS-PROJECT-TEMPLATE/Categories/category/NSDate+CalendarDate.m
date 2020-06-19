//
//  NSDate+CalendarDate.m
//  FWRACProject
//
//  Created by 金轶男 on 2017/4/27.
//  Copyright © 2017年 he. All rights reserved.
//

#import "NSDate+CalendarDate.h"

@implementation NSDate (CalendarDate)

- (NSInteger)day{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitDay) fromDate:self];
    return [components day];
}


- (NSInteger)month{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitMonth) fromDate:self];
    return [components month];
}

- (NSInteger)year{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear) fromDate:self];
    return [components year];
}


- (NSDateComponents *)dateComponents{

    NSDate *localeDate = self;//[self  getEarlyEightDate];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay|kCFCalendarUnitHour |kCFCalendarUnitMinute |kCFCalendarUnitSecond |kCFCalendarUnitWeekday) fromDate:localeDate];
    
    return components;
}

/**
 * 开始到结束的时间差
 */
- (NSInteger)dateTimeDifferenceWithOtherTime:(NSDate *)endTime{
    
    
    NSTimeInterval start = [[self getSystemTimeZoneDate] timeIntervalSince1970]*1;
    NSTimeInterval end = [[endTime getSystemTimeZoneDate] timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    value /= 60;
    DLog(@"%lf",value *1.0 / (24 * 60));
    
    int day = value / (24 * 60);

    if ((long)value % (24 * 60) >= 1)  {
        day ++;
    }
    
    return day;
}

/****
 iOS比较日期大小默认会比较到秒
 ****/
-(BOOL)isLaterAnotherDay:(NSDate *)anotherDay
{
 
    NSComparisonResult result = [self compare:anotherDay];

    if (result == NSOrderedDescending) {
        
        return YES;
    }
    else if (result ==NSOrderedAscending){
       
        return NO;
    }
    return NO;
}

- (NSDateComponents *)nextDateComponents{
       
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay|kCFCalendarUnitHour |kCFCalendarUnitMinute |kCFCalendarUnitSecond |kCFCalendarUnitWeekday) fromDate:self];
    
    return components;
}

- (NSDate *)getSystemTimeZoneDate{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: self];
    interval -= 8*60*60;
    
    NSDate *localeDate = [self  dateByAddingTimeInterval: interval];
    return localeDate;
}

- (NSDate *)getNextDayDate{
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: self];
    
    interval += 24 * 60 * 60;
    interval -= 8*60*60;
    
    NSDate *localeDate = [self  dateByAddingTimeInterval: interval];
    return localeDate;
}
- (NSDate *)getNextTowDayDate{
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: self];
    
    interval += 48 * 60 * 60;
    interval -= 8*60*60;
    
    NSDate *localeDate = [self  dateByAddingTimeInterval: interval];
    return localeDate;
}



- (NSDate *)getOneHoursLateDate{
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: self];
    
    interval += 1 * 60 * 60;
    interval -= 8*60*60;
    
    NSDate *localeDate = [self  dateByAddingTimeInterval: interval];
    
    return localeDate;
}


- (NSDate *)getAfterThirtyDay{
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: self];
    
    interval += 30 * 24 * 60 * 60;
    interval -= 8*60*60;
    
    NSDate *localeDate = [self  dateByAddingTimeInterval: interval];
    return localeDate;
}


- (NSDate *)getEarlyEightDate{
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: self];
    
    interval -= 16*60*60;
    
    NSDate *localeDate = [self  dateByAddingTimeInterval: interval];
    
    return localeDate;
}


- (NSInteger)firstWeekdayInThisMonth{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

- (NSInteger)totaldaysInMonth{
    NSRange daysInOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return daysInOfMonth.length;
}

- (NSDate *)lastMonth{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate*)nextMonth{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

//比较两个日期的大小  日期格式为2016-08-14 08：46：20
- (NSInteger)compareWithDate:(NSDate *)otherDate
{
    return  [self isEqualToDate:otherDate];
}

+ (NSString *)getWeekStr:(NSInteger)week{
    NSArray *arr = @[@"周日 ",@"周一 ",@"周二 ",@"周三 ",@"周四 ",@"周五 ",@"周六 "];
    
    return arr[week -1];
}

- (NSDate *)getTimeWith:(NSString *)fomart time:(NSDate *)date
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:fomart];
    NSString *dateTime=[formatter stringFromDate:date];
    NSDate *dat = [formatter dateFromString:dateTime];
    return dat;
}
- (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"oneDay : %@, anotherDay : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //在指定时间前面 过了指定时间 过期
     //one day是未来
        return 1;
    }
    else if (result == NSOrderedAscending){
   //another day是未来
        return 2;
    }
    //刚好时间一样.
    //NSLog(@"Both dates are the same");
    return 0;
    
}
@end
