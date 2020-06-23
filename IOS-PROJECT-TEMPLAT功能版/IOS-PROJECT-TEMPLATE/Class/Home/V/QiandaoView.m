//
//  QiandaoView.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/6/23.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "QiandaoView.h"
@interface QiandaoView()
@property(nonatomic,weak)IBOutlet UIView * hongBaoView;
@property(nonatomic,weak)IBOutlet UILabel * moneyLabel;
@property(nonatomic,weak)IBOutlet UILabel * signLabel;
@property(nonatomic,weak)IBOutlet UIButton * signButton;
@end
@implementation QiandaoView

-(void)setModel:(SignModel *)model
{
    for (UIView * view in self.hongBaoView.subviews) {
        [view removeFromSuperview];
    }
    
    self.moneyLabel.text =model.anniversaryMoney;
    NSString *usedStr = [NSString stringWithFormat:@"您已签到%@天",model.signInCount];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:usedStr];
    // 设置字体颜色
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,4)];
    [str addAttribute:NSForegroundColorAttributeName value:K_Prokect_MainColor range:NSMakeRange(4,model.signInCount.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(4+model.signInCount.length, 1)];
    // 设置字体
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0] range:NSMakeRange(4,model.signInCount.length)];
    
    self.signLabel.attributedText =str;
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
    
    CGFloat hongbao_width=40;
    CGFloat hongbao_height =70;
    CGFloat margin_x;
    if (model.additionalSignIn.count>5)
    {
        margin_x =(280 -hongbao_width *6)/(7);
        UIScrollView * scView= [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 280, 90)];
        scView.contentSize =CGSizeMake(280+(model.additionalSignIn.count-6)*(40+margin_x)+margin_x, 0);
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
        margin_x =(280 -hongbao_width *model.additionalSignIn.count)/(model.additionalSignIn.count+1);
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


-(IBAction)signClick:(id)sender
{
    if (self.delegate) {
        [self.delegate qiandaoClick];
    }
}

-(void)clickBag:(UIButton*)sender
{
    if (self.delegate) {
        [self.delegate hongbaoClick:sender];
    }
}

-(IBAction)close:(id)sender
{
    if (self.delegate) {
        [self.delegate qiandaoClose];
    }
}
@end
