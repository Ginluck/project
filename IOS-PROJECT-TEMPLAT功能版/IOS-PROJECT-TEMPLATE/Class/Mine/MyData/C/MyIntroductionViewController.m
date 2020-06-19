//
//  MyIntroductionViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/13.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "MyIntroductionViewController.h"
#import "UserTextView.h"
@interface MyIntroductionViewController ()
@property(nonatomic,strong)UserTextView *TxtView;

@end

@implementation MyIntroductionViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hideNavigationBar:NO animated:NO];
}
-(UserTextView *)TxtView
{
    if (!_TxtView) {
        _TxtView =[[UserTextView alloc]initWithFrame:CGRectMake(16, 12+kNavagationBarH, Screen_Width-32, 240-24)];
    }
    return _TxtView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.TxtView];
      [self addNavigationTitleView:@"个人简介"];
    // Do any additional setup after loading the view from its nib.
    self.TxtView.placeholder=@"请填写你的简介";
    self.TxtView.placeholderColor=[UIColor lightGrayColor];
    [self addNavigationItemWithTitle:@"提交" itemType:kNavigationItemTypeRight action:@selector(SubmitClick)];
    [self requsetData];
}
-(void)requsetData
{
    UserModel * model =[[UserManager shareInstance]getUser];
       NSDictionary* param_dic =@{@"userPhone":model.userPhone};
       [RequestHelp POST:SELECT_USERINFO_url parameters:param_dic success:^(id result) {
           MKLog(@"%@",result);
           self.TxtView.text=result[@"introduce"];
       } failure:^(NSError *error) {
           
       }];
}
-(void)SubmitClick
{
    UserModel * model =[[UserManager shareInstance]getUser];
    NSString *str = self.TxtView.text;
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.TxtView.text = str;
    if (str.length < 1 || [str isEqualToString:self.TxtView.placeholder]) {
        ShowErrorStatus(@"请填写你的简介");
        return;
    }
//    WS(weakSelf);
    ShowMaskStatus(@"提交中...");
    NSDictionary* param_dic =@{@"userPhone":model.userPhone,@"introduce":self.TxtView.text};
             [RequestHelp POST:UPDATE_ZJ_url parameters:param_dic success:^(id result) {
                 MKLog(@"%@",result);
                 ShowMessage(@"修改成功");
                 model.introduce =self.TxtView.text;
                  [[UserManager shareInstance]saveUser:model];
             } failure:^(NSError *error) {
                 
             }];
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
