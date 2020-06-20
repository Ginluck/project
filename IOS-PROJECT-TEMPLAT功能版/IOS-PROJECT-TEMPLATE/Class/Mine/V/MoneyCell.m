//
//  MoneyCell.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/6/11.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "MoneyCell.h"
@interface MoneyCell()

@end
@implementation MoneyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.calendarView addSubview:self.cView];
}
-(IBAction)signClick:(id)sender
{
    if (self.delegate) {
        [self.delegate signBtnClick:sender];
    }
}
-(void)reloadCell:(SignModel * )model
{
    for (UIView * view in self.hongBaoView.subviews) {
        [view removeFromSuperview];
    }
    
    self.moneyLabel.text =model.anniversaryMoney;
    self.signLabel.text =[NSString stringWithFormat:@"您已签到%@天",model.signInCount];
    if ([model.signInType isEqualToString:@"1"])
    {
        [self.signButton setTitle:@" 已 签 到" forState:UIControlStateNormal];
        [self.signButton setBackgroundImage:KImageNamed(@"立即签到灰色") forState:UIControlStateNormal];;
        self.signButton.userInteractionEnabled=NO;
    }
    else
    {
        [self.signButton setTitle:@"立 即 签 到" forState:UIControlStateNormal];
        [self.signButton setBackgroundImage:KImageNamed(@"立即签到黄色") forState:UIControlStateNormal];;
        self.signButton.userInteractionEnabled=YES;
    }
    NSMutableArray * ary =[NSMutableArray array];
    for (int i=0; i<model.signInTimeList.count; i++)
    {
        NSString * time =model.signInTimeList[i];
        NSDate * date =[NSDate dateWithFormat:@"yyyy-MM-dd" dateString:time];
        [ary addObject:date];
    }
     self.cView.selectedAry =ary;
    
    CGFloat hongbao_width=40;
    CGFloat hongbao_height =70;
    CGFloat margin_x;
    if (model.additionalSignIn.count>6)
    {
        margin_x =(Screen_Width -hongbao_width *6)/(7);
        UIScrollView * scView= [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 90)];
        scView.contentSize =CGSizeMake(Screen_Width+(model.additionalSignIn.count-6)*(40+margin_x)+margin_x, 0);
        scView.showsHorizontalScrollIndicator=NO;
        [self.hongBaoView addSubview:scView];
        
        for ( int i =0; i<model.additionalSignIn.count; i++)
        {
            HongBaoView * hongbao =[[HongBaoView alloc]initWithFrame:CGRectMake(margin_x+(margin_x +hongbao_width)*i, 10, hongbao_height, hongbao_width)];
            SigninChild * child =model.additionalSignIn[i];
            hongbao.days.text =[NSString stringWithFormat:@"%@天",child.consecutiveDays];
            hongbao.action.tag =i;
            if ([child.type isEqualToString:@"1"])
            {
                [hongbao.action addTarget:self action:@selector(clickBag:) forControlEvents:UIControlEventTouchUpInside];
                [hongbao.action setImage:KImageNamed(@"红包") forState:UIControlStateNormal];
            }
            else if ([child.type isEqualToString:@"2"])
            {
                [hongbao.action setImage:KImageNamed(@"红包打开") forState:UIControlStateNormal];
            }
            else
            {
                [hongbao.action setImage:KImageNamed(@"红包灰色") forState:UIControlStateNormal];
            }
            
            [scView addSubview:hongbao];
        }
        
    }
    else
    {
        margin_x =(Screen_Width -hongbao_width *model.additionalSignIn.count)/(model.additionalSignIn.count+1);
        for ( int i =0; i<model.additionalSignIn.count; i++)
        {
            HongBaoView * hongbao =[[HongBaoView alloc]initWithFrame:CGRectMake(margin_x+(margin_x +hongbao_width)*i, 10, hongbao_height, hongbao_width)];
            SigninChild * child =model.additionalSignIn[i];
            hongbao.days.text =[NSString stringWithFormat:@"%@天",child.consecutiveDays];
            hongbao.action.tag =i;
            if ([child.type isEqualToString:@"1"])
            {
                [hongbao.action addTarget:self action:@selector(clickBag:) forControlEvents:UIControlEventTouchUpInside];
                [hongbao.action setImage:KImageNamed(@"红包") forState:UIControlStateNormal];
            }
            else if ([child.type isEqualToString:@"2"])
            {
                  [hongbao.action setImage:KImageNamed(@"红包打开") forState:UIControlStateNormal];
            }
            else
            {
                  [hongbao.action setImage:KImageNamed(@"红包灰色") forState:UIControlStateNormal];
            }
            [self.hongBaoView addSubview:hongbao];
        }
    }
}

-(void)clickBag:(UIButton*)sender
{
    if (self.delegate) {
        [self.delegate moneyBtnClick:sender];
    }
}
-(CalendarView *)cView
{
    if (!_cView) {
        _cView =[[CalendarView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 230)];
    }
    return _cView;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
