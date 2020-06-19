//
//  ChangePwdViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/9.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "ChangePwdViewController.h"
#import "NSString+Encryption.h"
@interface ChangePwdViewController ()
@property(nonatomic,strong) NSString *Pwdstr;
@end

@implementation ChangePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self addNavigationTitleView:@"修改密码"];
    [self.OldTF addTarget:self action:@selector(passwordTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.NewTF  addTarget:self action:@selector(passwordTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.AgainTF  addTarget:self action:@selector(passwordTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    // Do any additional setup after loading the view from its nib.
}
- (void)passwordTextFieldDidChange:(UITextField *)textField{
    if (textField.text.length > 16) {
           ShowMessage(@"密码不能超过16位");
          textField.text=self.Pwdstr;
       }
    else if (textField.text.length < 8)
       {
           ShowMessage(@"密码不能小于8位");
            textField.text=self.Pwdstr;
       }
    else
       {
           self.Pwdstr=textField.text;
       }
}
- (IBAction)Submit:(id)sender {
    if (self.OldTF.text.length<=0)
       {
          ShowMessage(@"请输入旧密码");
           return;
       }
    if (![self.NewTF.text isEqualToString:self.AgainTF.text]) {
       ShowMessage(@"两次密码输入不一致");
        return;
    }
    if (self.NewTF.text.length<=0) {
       ShowMessage(@"请输入新密码");
        return;
    }
    UserModel * model =[[UserManager shareInstance]getUser];
           [RequestHelp POST:UPDATE_PC_url parameters:@{@"userPhone":model.userPhone,@"password":self.OldTF.text,@"newPassword":[self.NewTF.text encryptAESWithkey:[UIUtils getCurrentTimes]]} success:^(id result){
                    DLog(@"%@",result);
                     ShowMessage(@"修改成功");
               [self logOut];
                 } failure:^(NSError *error) {

                }];
   
    
}
-(void)logOut
{


    UserModel * model =[[UserManager shareInstance]getUser];
    [RequestHelp POST:exit_url parameters:@{@"userPhone":model.userPhone} success:^(id result){
       DLog(@"%@",result);
        [[UserManager shareInstance]removeUserId];
        [[UserManager shareInstance]removeToken];
        [[UserManager shareInstance]removeUser];
        [ViewControllerManager showLoginViewController];
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
