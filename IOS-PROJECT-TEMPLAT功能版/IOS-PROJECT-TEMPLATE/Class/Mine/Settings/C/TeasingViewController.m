//
//  TeasingViewController.m
//  路丫租车-三期
//
//  Created by Apple on 2018/11/30.
//  Copyright © 2018 ginluck. All rights reserved.
//

#import "TeasingViewController.h"
#import "UserTextView.h"
@interface TeasingViewController ()
@property (strong, nonatomic)  UserTextView *TxtView;
@end

@implementation TeasingViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hideNavigationBar:NO animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _TxtView =[[UserTextView alloc]initWithFrame:CGRectMake(16, 16+kNavagationBarH, Screen_Width-32, 300)];
    [self.view addSubview:self.TxtView];
    [self addNavigationTitleView:@"意见反馈"];
    // Do any additional setup after loading the view from its nib.
    self.TxtView.placeholder=@"写点什么吧...";
    self.TxtView.placeholderColor=[UIColor lightGrayColor];
    
    UIButton *Btn =[[UIButton alloc]initWithFrame:CGRectMake(36, 332+kNavagationBarH, Screen_Width-72, 40)];
    [Btn setTitle:@"提交" forState:UIControlStateNormal];
    [Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Btn.backgroundColor=K_Prokect_MainColor;
    [Btn addTarget:self action:@selector(SubmitClick) forControlEvents:UIControlEventTouchUpInside];
     Btn.layer.masksToBounds=YES;
    Btn.layer.cornerRadius=20;
    [self.view addSubview:Btn];
//    [self addNavigationItemWithTitle:@"提交" itemType:kNavigationItemTypeRight action:@selector(SubmitClick)];
}
-(void)SubmitClick
{
    NSString *str = self.TxtView.text;
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.TxtView.text = str;
    if (str.length < 1 || [str isEqualToString:self.TxtView.placeholder]) {
        ShowErrorStatus(@"请填写意见内容");
        return;
    }
    WS(weakSelf);
//    ShowMaskStatus(@"提交中...");
//    [RequestHelp POST:OTHER_COMPLAINT_URL parameters:@{@"content":self.TxtView.text,@"mobile":self.PhoneTF.text} success:^(id result) {
//        DismissHud();
      ShowMessage(@"提交成功");
//
        [weakSelf.navigationController popViewControllerAnimated:YES];
//    } failure:^(NSError *error) {
//        ShowMessage(@"提交失败");
//    }];
}
-(void)setBgView:(UIView *)BgView
{
    BgView.layer.masksToBounds=YES;
    BgView.layer.borderColor=COLOR_HEX(0x8a96a5).CGColor;
    BgView.layer.borderWidth=.5;
}
-(void)setPhoneView:(UIView *)PhoneView
{
    PhoneView.layer.masksToBounds=YES;
    PhoneView.layer.borderColor=COLOR_HEX(0x8a96a5).CGColor;
    PhoneView.layer.borderWidth=.5;
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
