//
//  CalendarView.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/6/11.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "CalendarView.h"
#import <Masonry.h>
#import <EventKit/EventKit.h>
#import "LunarFormatter.h"
#import "FSCalendar.h"
@interface CalendarView()<FSCalendarDataSource,FSCalendarDelegate>
@property (strong  , nonatomic) FSCalendar *calendar;
@property (strong, nonatomic) NSCalendar *gregorian;
@property (assign, nonatomic) NSInteger SignCount;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSDate *minimumDate;
@property (strong, nonatomic) NSDate *maximumDate;
@property (strong, nonatomic) NSCache *cache;
@property (assign, nonatomic) BOOL showsLunar;
@property (assign, nonatomic) BOOL showsEvents;
@property (strong, nonatomic) LunarFormatter *lunarFormatter;
@property (strong, nonatomic) NSArray<EKEvent *> *events;

@property (strong,nonatomic) NSString *dateStr;
@end
@implementation CalendarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setSelectedAry:(NSArray *)selectedAry
{
    _selectedAry=selectedAry;
    if (_selectedAry.count) {
        //允许用户选择,其实是允许系统来选中签到日期
        self.calendar.allowsSelection = YES;
        self.calendar.allowsMultipleSelection = YES;
        for (int i=0; i<_selectedAry.count; i++)
        {
            if (![self.calendar.selectedDates containsObject:_selectedAry[i]])
            {
                [self.calendar selectDate:_selectedAry[i]];
            }
        }
         self.calendar.allowsSelection = NO;
    }
    else
    {
        ShowMessage(@"暂时没有签到日期");
    }
}


- (LunarFormatter *)lunarFormatter{
    if (!_lunarFormatter) {
        _lunarFormatter = [[LunarFormatter alloc] init];
    }
    return _lunarFormatter;
}

- (NSDateFormatter *)dateFormatter{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc]init];
        _dateFormatter.dateFormat = @"yyyy-MM-dd";
    }
    return _dateFormatter;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame: frame])
    {
        self.frame =frame;
        [self addSubview:self.calendar];
    }
    return self;
}

-(FSCalendar *)calendar
{
    if (!_calendar) {
        _calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _calendar.center =CGPointMake(self.frame.size.width/2, 140);
        _calendar.backgroundColor = [UIColor whiteColor];
        _calendar.dataSource = self;
        _calendar.delegate = self;
        //日历语言为中文
        _calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
        //允许多选,可以选中多个日期
        _calendar.allowsMultipleSelection = YES;
        _calendar.allowsSelection =NO;
        _calendar.scrollEnabled=NO;
        //如果值为1,那么周日就在第一列,如果为2,周日就在最后一列
        _calendar.firstWeekday = 1;
        //周一\二\三...或者头部的2017年11月的显示方式
        _calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase|FSCalendarCaseOptionsHeaderUsesUpperCase;
    }
    return _calendar;
}


//获取日历范围,让日历出现时就知道该显示哪个月了哪一页了(根据系统时间来获取)
-(NSArray *)getStartTimeAndFinalTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    NSDate *newDate=[formatter dateFromString:currentTimeString];
    double interval = 0;
    NSDate *firstDate = nil;
    NSDate *lastDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    BOOL OK = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:& firstDate interval:&interval forDate:newDate];
    if (OK) {
        lastDate = [firstDate dateByAddingTimeInterval:interval - 1];
    }else {
        return @[@"",@""];
    }
    NSString *firstString = [formatter stringFromDate: firstDate];
    NSString *lastString = [formatter stringFromDate: lastDate];
    //返回数据为日历要显示的最小日期firstString和最大日期lastString
    return @[firstString, lastString];
}

#pragma mark - <配置日历>
- (void)calendarConfig{
    //创建系统日历类
    self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //获取日历要显示的日期范围
    NSArray *timeArray = [self getStartTimeAndFinalTime];
    self.dateStr = [timeArray[0] substringToIndex:7];
    //设置最小和最大日期(在最小和最大日期之外的日期不能被选中,日期范围如果大于一个月,则日历可翻动)
    self.minimumDate = [self.dateFormatter dateFromString:timeArray[0]];
    self.maximumDate = [self.dateFormatter dateFromString:timeArray[1]];
    self.calendar.accessibilityIdentifier = @"calendar";
    //title显示方式
    self.calendar.appearance.headerDateFormat = @"yyyy年MM月";
    //关闭字体自适应,设置字体大小\颜色
    self.calendar.appearance.adjustsFontSizeToFitContentSize = NO;
    self.calendar.appearance.subtitleFont = [UIFont systemFontOfSize:8];
    self.calendar.appearance.headerTitleColor = [UIColor whiteColor];
    self.calendar.appearance.weekdayTextColor = [UIColor whiteColor];
    self.calendar.appearance.selectionColor = [UIColor orangeColor];
    //日历头部颜色
//    self.calendar.calendarHeaderView.backgroundColor = themeColor;
//    self.calendar.calendarWeekdayView.backgroundColor = themeColor;
//    //载入节假日
//    [self loadCalendarEvents];
//    //显示农历
//    [self lunarItemClicked];
//    //显示节假日
//    [self eventItemClicked];
}


@end
