//
//  NSDate+CalendarDate.h
//  FWRACProject
//
//  Created by 金轶男 on 2017/4/27.
//  Copyright © 2017年 he. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CalendarDate)

- (NSInteger)day;

- (NSInteger)month;

- (NSInteger)year;

- (NSInteger)firstWeekdayInThisMonth;

- (NSInteger)totaldaysInMonth;

- (NSDate *)lastMonth;
- (NSDate*)nextMonth;

- (NSInteger)compareWithDate:(NSDate *)otherDate;

- (NSDateComponents *)dateComponents;

- (NSDateComponents *)nextDateComponents;

+ (NSString *)getWeekStr:(NSInteger)week;


- (NSDate *)getSystemTimeZoneDate;

- (NSDate *)getNextDayDate;

- (NSDate *)getOneHoursLateDate;

- (NSDate *)getNextTowDayDate;

- (NSDate *)getAfterThirtyDay;

- (NSDate *)getEarlyEightDate;
/****
 iOS比较日期大小默认会比较到秒
 ****/
-(BOOL)isLaterAnotherDay:(NSDate *)anotherDay;
/**
 * 开始到结束的时间差
 */
- (NSInteger)dateTimeDifferenceWithOtherTime:(NSDate *)endTime;

- (NSDate *)getTimeWith:(NSString *)fomart time:(NSDate *)date;
- (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;
@end
