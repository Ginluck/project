//
//  NewPhoneViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/9.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "NewPhoneViewController.h"
#import "UILabel+WY_RichText.h"
#import "NSMutableParagraphStyle+WY_Extension.h"
#import "NSMutableAttributedString+WY_Extension.h"
#import "NSString+Encryption.h"
#import "IDSafeViewController.h"
@interface NewPhoneViewController ()

@end

@implementation NewPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitleView:@"输入新手机号"];
    [self.PhoneTF addTarget:self action:@selector(phoneNumberTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)phoneNumberTextFieldDidChange:(UITextField *)textField{
    if (textField.text.length > 11) {
       textField.text=[textField.text  substringToIndex:11];
    }
}
- (IBAction)CodeClick:(JKCountDownButton *)sender {
    if (![UIUtils isValidateMobile:self.PhoneTF.text]) {
        ShowMessage(@"请输入正确的手机号");
        return;
    }

    WS(weakSelf);
  
    
    NSDictionary *dicParams = @{@"userPhone":self.PhoneTF.text,@"codeType":@"12"};
    
    [RequestHelp POST:GETSECURITYCODE_url parameters:dicParams success:^(id result) {
        weakSelf.CodeBtn.enabled = NO;
        [weakSelf.CodeBtn startWithSecond:60];
        [weakSelf.CodeBtn didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
            NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
            return title;
        }];
        [weakSelf.CodeBtn didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
            countDownButton.enabled = YES;
            return @"重新获取";
        }];
    } failure:^(NSError *error) {
        
    }];
    
}
- (IBAction)Submit:(id)sender {
    if (self.CodeTF.text.length>0) {
                UserModel * model =[[UserManager shareInstance]getUser];
        [RequestHelp POST:registers_url parameters:@{@"userPhone":model.userPhone,@"userId":model.id,@"validCode":self.CodeTF.text} success:^(id result){
                        DLog(@"%@",result);
                         ShowMessage(@"绑定成功");
//                         for(UIViewController*temp in self.navigationController.viewControllers) {
//
//                           if([temp isKindOfClass:[IDSafeViewController class]]) {
//
//                           [self.navigationController popToViewController:temp animated:YES];  }
//
//                           }
            UserModel * model =[[UserManager shareInstance]getUser];
               [RequestHelp POST:exit_url parameters:@{@"userPhone":model.userPhone} success:^(id result){
                  DLog(@"%@",result);
                   [[UserManager shareInstance]removeUserId];
                   [[UserManager shareInstance]removeToken];
                   [[UserManager shareInstance]removeUser];
                   [ViewControllerManager showLoginViewController];
               } failure:^(NSError *error) {

              }];
                     } failure:^(NSError *error) {

                    }];
           }else
           {
              ShowMessage(@"请输入验证码");
           }
   

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
