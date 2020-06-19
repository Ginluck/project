//
//  MoneyView.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/6/11.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "MoneyView.h"
#import "HongBaoView.h"
#import "CalendarView.h"
@interface MoneyView()
@property(nonatomic,weak)IBOutlet UIView * hongBaoView;
@property(nonatomic,weak)IBOutlet UILabel * moneyLabel;
@property(nonatomic,weak)IBOutlet UILabel * signLabel;

@property(nonatomic,weak)IBOutlet UIView * calendarView;
@property(nonatomic,strong)CalendarView  * cView;
@end
@implementation MoneyView



-(void)awakeFromNib
{
    [super awakeFromNib];
    
    CGFloat margin_x =(Screen_Width -256)/7;
    
    NSArray * ary =@[@"3天",@"7天",@"10天",@"15天",@"20天",@"25天"];
    
    for ( int i =0; i<ary.count; i++)
    {
        HongBaoView * hongbao =[[HongBaoView alloc]initWithFrame:CGRectMake(margin_x+(margin_x +40)*i, 10, 70, 40)];
        hongbao.days.text =ary[i];
        [self.hongBaoView addSubview:hongbao];
    }
    [self.calendarView addSubview:self.cView];
}
-(IBAction)calendarClick
{
    if (self.delegate) {
        [self.delegate calendarBtnClick];
    }
}


-(CalendarView *)cView
{
    if (!_cView) {
        _cView =[[CalendarView alloc]initWithFrame:CGRectMake(10, 10, Screen_Width-52, Screen_Width-52)];
    }
    return _cView;
}


-(IBAction)inviteClick
{
    if (self.delegate) {
        [self.delegate inviteBtnClick];
    }
}
@end
