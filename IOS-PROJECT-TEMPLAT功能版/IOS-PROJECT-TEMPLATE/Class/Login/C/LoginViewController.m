//
//  LoginViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2019/12/10.
//  Copyright © 2019年 梦境网络. All rights reserved.
//

#import "LoginViewController.h"
#import "NSString+Encryption.h"
#import "RegisterViewController.h"
#import "YourNameAdressViewController.h"
#import "TPNavigationController.h"
#import "ForgetPwdViewController.h"
@interface LoginViewController ()
@property(nonatomic,strong) NSString *Pwdstr;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.NumberTF addTarget:self action:@selector(phoneNumberTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.PwdTF  addTarget:self action:@selector(passwordTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    UserModel *model =[[UserManager shareInstance]getUser];
    if (model !=nil) {
        if (model.realName ==nil ||model.realName ==NULL||model.realName.length==0 ) {
                      YourNameAdressViewController *YNAVC=[YourNameAdressViewController new];
                      TPNavigationController *navC = [[TPNavigationController alloc]initWithRootViewController:YNAVC];
                                 navC.modalPresentationStyle=UIModalPresentationFullScreen;
                             [self presentViewController: navC animated:NO completion:nil];
                  }else
                  {
                      [ViewControllerManager showMainViewController];
                  }
    }
   
    // Do any additional setup after loading the view from its nib.
}
- (void)phoneNumberTextFieldDidChange:(UITextField *)textField{
    if (textField.text.length > 11) {
       textField.text=[textField.text  substringToIndex:11];
    }
}
- (void)passwordTextFieldDidChange:(UITextField *)textField{
   
    if (textField.text.length > 16) {
        ShowMessage(@"密码不能超过16位");
       textField.text=self.Pwdstr;
    }else
    {
        self.Pwdstr=textField.text;
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hideNavigationBar:YES animated:NO];
}
-(void)setNumberView:(UIView *)NumberView
{
     NumberView.layer.masksToBounds=YES;
       
       NumberView.layer.shadowColor =COLOR(225, 225, 225, 1).CGColor;
       
       NumberView.layer.shadowOffset = CGSizeMake(1, 1);
       
       NumberView.layer.shadowOpacity = 1;
       
       NumberView.layer.shadowRadius = 3.0;
       
       NumberView.layer.cornerRadius = 30.0*Kscale;
       
       NumberView.clipsToBounds = NO;
}
-(void)setPwdView:(UIView *)PwdView
{
     PwdView.layer.masksToBounds=YES;
       
       PwdView.layer.shadowColor =COLOR(225, 225, 225, 1).CGColor;
       
       PwdView.layer.shadowOffset = CGSizeMake(1, 1);
       
       PwdView.layer.shadowOpacity = 1;
       
       PwdView.layer.shadowRadius = 3.0;
       
       PwdView.layer.cornerRadius = 30.0*Kscale;
       
       PwdView.clipsToBounds = NO;
}
-(void)setLoginBtn:(UIButton *)LoginBtn
{
          LoginBtn.layer.masksToBounds=YES;
          
       
          
          LoginBtn.layer.cornerRadius = 30.0*Kscale;
          
         
}
- (IBAction)LoginClick:(id)sender {
    if (self.PwdTF.text.length==0) {
        ShowMessage(@"请输入密码");
        return;
    }
    NSDictionary * dic = @{@"userPhone":self.NumberTF.text,@"password":[self.PwdTF.text encryptAESWithkey:[UIUtils getCurrentTimes]]};
    [RequestHelp POST:login_url parameters:dic success:^(id result) {
//        DLog(@"%@",result);
        [self.view endEditing:YES];
        UserModel * modal  = [UserModel yy_modelWithJSON:result];
        [[UserManager shareInstance]saveUser:modal];
        [[UserManager shareInstance]saveToken:result[@"token"]];
       
        if (modal.realName ==nil ||modal.realName ==NULL||modal.realName.length==0 ) {
            YourNameAdressViewController *YNAVC=[YourNameAdressViewController new];
            TPNavigationController *navC = [[TPNavigationController alloc]initWithRootViewController:YNAVC];
                       navC.modalPresentationStyle=UIModalPresentationFullScreen;
                   [self presentViewController: navC animated:NO completion:nil];
        }else
        {
            [ViewControllerManager showMainViewController];
        }
//        [JPUSHService setAlias:modal.id completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
//
//        } seq:5];
        [[EMClient sharedClient] loginWithUsername:modal.ringLetterId password:modal.password completion:^(NSString *aUsername, EMError *aError) {
            if (!aError) {
                NSLog(@"登录成功");
            } else {
                NSLog(@"登录失败的原因---%@", aError.errorDescription);
            }
        }];
    } failure:^(NSError *error) {

    }];
    
    
}
- (IBAction)ForgetClick:(id)sender {
    ForgetPwdViewController *RVC=[ForgetPwdViewController new];
    [self.navigationController pushViewController:RVC animated:YES];
}
- (IBAction)RegisterClick:(id)sender {
    RegisterViewController *RVC=[RegisterViewController new];
    [self.navigationController pushViewController:RVC animated:YES];
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
