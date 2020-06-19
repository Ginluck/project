//
//  RecordMoneyViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/6/15.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "RecordMoneyViewController.h"
#import "HongBaoView.h"
#import "CalendarView.h"
#import "SignModel.h"
#import "NSDate+CommonDate.h"
@interface RecordMoneyViewController ()
@property(nonatomic,weak)IBOutlet UIView * hongBaoView;
@property(nonatomic,weak)IBOutlet UILabel * moneyLabel;
@property(nonatomic,weak)IBOutlet UILabel * signLabel;
@property(nonatomic,weak)IBOutlet UIButton * signButton;
@property(nonatomic,weak)IBOutlet UIView * calendarView;
@property(nonatomic,strong)CalendarView  * cView;
@property(nonatomic,strong)SignModel  * model;
@end

@implementation RecordMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavigationTitleView:@"签到记录"];
    [self.calendarView addSubview:self.cView];
    [self requestData];
}
-(CalendarView *)cView
{
    if (!_cView) {
        _cView =[[CalendarView alloc]initWithFrame:CGRectMake(0, 20, Screen_Width-32, Screen_Width-52)];
//        _cView.center =CGPointMake(Screen_Width/2, Screen_Width/2-16);
    }
    return _cView;
}

-(void)requestData
{
    ShowMaskStatus(@"加载数据中");
    [RequestHelp POST:JS_SIGNRECORD_URL parameters:@{} success:^(id result) {
        MKLog(@"%@",result);
        DismissHud();
        self.model  =[SignModel yy_modelWithJSON:result];
        [self refreshUICompents];
    } failure:^(NSError *error) {
         DismissHud();
    }];
}



-(void)refreshUICompents
{
    for (UIView * view in self.hongBaoView.subviews) {
        [view removeFromSuperview];
    }
    
    self.moneyLabel.text =self.model.anniversaryMoney;
    self.signLabel.text =[NSString stringWithFormat:@"您已签到%@天",self.model.signInCount];
    if ([self.model.signInType isEqualToString:@"1"])
    {
        [self.signButton setTitle:@"已签到" forState:UIControlStateNormal];
        [self.signButton setBackgroundColor:[UIColor lightGrayColor]];
        self.signButton.userInteractionEnabled=NO;
    }
    else
    {
        [self.signButton setTitle:@"签到" forState:UIControlStateNormal];
        [self.signButton setBackgroundColor:K_Prokect_MainColor];
        self.signButton.userInteractionEnabled=YES;
    }
    NSMutableArray * ary =[NSMutableArray array];
    for (int i=0; i<self.model.signInTimeList.count; i++)
    {
        NSString * time =self.model.signInTimeList[i];
        NSDate * date =[NSDate dateWithFormat:@"yyyy-MM-dd" dateString:time];
        [ary addObject:date];
    }
    self.cView.selectedAry =ary;

    CGFloat hongbao_width=40;
    CGFloat hongbao_height =70;
    CGFloat margin_x;
    if (self.model.additionalSignIn.count>6)
    {
        margin_x =(Screen_Width -hongbao_width *6)/(7);
        UIScrollView * scView= [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width-32, 90)];
        scView.contentSize =CGSizeMake(Screen_Width-32+(self.model.additionalSignIn.count-6)*(40+margin_x)+margin_x, 0);
        [self.hongBaoView addSubview:scView];
        
        for ( int i =0; i<self.model.additionalSignIn.count; i++)
        {
            HongBaoView * hongbao =[[HongBaoView alloc]initWithFrame:CGRectMake(margin_x+(margin_x +hongbao_width)*i, 10, hongbao_height, hongbao_width)];
            SigninChild * child =self.model.additionalSignIn[i];
            hongbao.days.text =[NSString stringWithFormat:@"%@天",child.consecutiveDays];
            hongbao.action.tag =i;
            if ([child.type isEqualToString:@"1"])
            {
                [hongbao.action addTarget:self action:@selector(clickBag:) forControlEvents:UIControlEventTouchUpInside];
            }
          
            [scView addSubview:hongbao];
        }
        
    }
    else
    {
       margin_x =(Screen_Width -hongbao_width *self.model.additionalSignIn.count)/(self.model.additionalSignIn.count+1);
        for ( int i =0; i<self.model.additionalSignIn.count; i++)
        {
            HongBaoView * hongbao =[[HongBaoView alloc]initWithFrame:CGRectMake(margin_x+(margin_x +hongbao_width)*i, 10, hongbao_height, hongbao_width)];
            SigninChild * child =self.model.additionalSignIn[i];
            hongbao.days.text =[NSString stringWithFormat:@"%@天",child.consecutiveDays];
            hongbao.action.tag =i;
            if ([child.type isEqualToString:@"1"])
            {
                [hongbao.action addTarget:self action:@selector(clickBag:) forControlEvents:UIControlEventTouchUpInside];
            }
            [self.hongBaoView addSubview:hongbao];
        }
    }
}

-(void)clickBag:(UIButton *)sender
{
    SigninChild *model =self.model.additionalSignIn[sender.tag];
    [RequestHelp POST:JS_GETREWARD_URL parameters:@{@"consecutiveDays":model.consecutiveDays} success:^(id result) {
        ShowMessage(result);
        [self requestData];
    } failure:^(NSError *error) {
        
    }];
}

-(IBAction)signIn:(id)sender
{
    [RequestHelp POST:JS_SIGNIN_URL parameters:@{} success:^(id result) {
        ShowMessage(result);
    } failure:^(NSError *error) {
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
