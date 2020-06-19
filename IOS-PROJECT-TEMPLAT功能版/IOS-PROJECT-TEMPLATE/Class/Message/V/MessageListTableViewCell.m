//
//  MessageListTableViewCell.m
//  RentHouseApp
//
//  Created by Apple on 2019/4/2.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "MessageListTableViewCell.h"
@interface MessageListTableViewCell()

@end
@implementation MessageListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)refreshSystem:(MessageListModel *)model;
{
    self.nameLabel.text =model.title;
    self.messageLabel.text =model.content;
    self.timeLabel.text =model.create_time;
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:KImageNamed(@"系统消息")];
//    if ([model.isRead isEqualToString:@"1"])
//    {
        self.isRead.hidden =YES;
//    }
//    else
//    {
//        self.isRead.hidden=NO;
//    }
//
}
//-(void)refreshHouse:(SystemMessageModel *)model
//{
//    self.nameLabel.text =model.title;
//    self.messageLabel.text =model.content;
//    self.headerImage.image =ImageNamed(@"系统消息");
//    switch ([model.type intValue]) {
//        case 1:
//        {
//            self.timeLabel.text =@"楼盘资讯";
//        }
//            break;
//        case 2:
//        {
//            self.timeLabel.text =@"优惠信息";
//        }
//            break;
//        case 3:
//        {
//            self.timeLabel.text =@"最新活动";
//        }
//            break;
//        case 4:
//        {
//            self.timeLabel.text =@"开盘加推";
//        }
//            break;
//        case 5:
//        {
//            self.timeLabel.text =@"施工进度";
//        }
//            break;
//            
//        default:
//            break;
//    }
//    
//}
-(void)refreshMessage:(UserModel *)model
{
    self.nameLabel.text =model.realName;
    self.messageLabel.text =model.lastMessage;
    self.timeLabel.text =model.messageTime;
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:model.headAddress]];
    
        if ([model.isRead isEqualToString:@"1"])
        {
           self.isRead.hidden =YES;
        }
        else
        {
            self.isRead.hidden=YES;
        }
}
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}
//#pragma mark根据时间戳进行时间判断
//-(NSString *)timeStr:(long long)timestamp
//{
//    // 创建日历对象
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    // 获取当前时间
//    NSDate *currentDate = [NSDate date];
//    // 获取当前时间的年、月、日。利用日历
//    NSDateComponents *components = [calendar components:NSCalendarUnitYear| NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
//    NSInteger currentYear = components.year;
//    NSInteger currentMonth = components.month;
//    NSInteger currentDay = components.day;
//    // 获取消息发送时间的年、月、日
//    NSDate *msgDate = [NSDate dateWithTimeIntervalSince1970:timestamp / 1000.0];
//    components = [calendar components:NSCalendarUnitYear| NSCalendarUnitMonth|NSCalendarUnitDay fromDate:msgDate];
//    CGFloat msgYear = components.year;
//    CGFloat msgMonth = components.month;
//    CGFloat msgDay = components.day;
//    // 进行判断
//    NSDateFormatter *dateFmt = [[NSDateFormatter alloc] init];
//    if (currentYear == msgYear && currentMonth == msgMonth && currentDay == msgDay)
//    {
//        //今天
//        dateFmt.dateFormat = @"HH:mm";
//    }
//    else if (currentYear == msgYear && currentMonth == msgMonth && currentDay-1 == msgDay)
//    {
//        //昨天
//        dateFmt.dateFormat = @"昨天 HH:mm";
//    }
//    else if(currentYear==msgYear && currentMonth==msgMonth && currentDay-msgDay>1 &&currentDay-msgDay<=7)
//    {
//        //当前时间的2天之前且一周之内
//        NSString *week=[self getWeekDayFordate:timestamp];
//        dateFmt.dateFormat=[NSString stringWithFormat:@"%@ HH:mm",week];
//        
//    }
//    else if(currentYear-msgYear>=1)
//    {
//        //今年之前
//        dateFmt.dateFormat=@"yyyy-MM-dd HH:mm";
//    }
//    else
//    {
//        //前天前
//        dateFmt.dateFormat = @"MM-dd HH:mm";
//    }
//    // 返回处理后的结果
//    return [dateFmt stringFromDate:msgDate];
//}
//
//-(NSString *)textFromMessage:(EMMessage *)message
//{
//    EMMessageBody *body = message.body;
//    EMTextMessageBody *textBody = (EMTextMessageBody *)body;
//    NSString *text = textBody.text;
//    return text;
//}
//#pragma mark根据时间戳获取周几
//-(NSString *)getWeekDayFordate:(long long)data
//{
//    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
//    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:data];
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSDateComponents *components =[calendar components:NSCalendarUnitWeekday fromDate:newDate];
//    NSString *weekStr =[weekday objectAtIndex:components.weekday];
//    return weekStr;
//}
@end
