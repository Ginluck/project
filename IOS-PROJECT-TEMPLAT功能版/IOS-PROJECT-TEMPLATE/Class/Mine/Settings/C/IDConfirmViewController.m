//
//  IDConfirmViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/9.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "IDConfirmViewController.h"
#import "NewPhoneViewController.h"
#import "NSString+Encryption.h"
@interface IDConfirmViewController ()

@end

@implementation IDConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitleView:@"身份确认"];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)Next:(id)sender {

        if (self.PwdTF.text.length>0) {
             UserModel * model =[[UserManager shareInstance]getUser];
            [RequestHelp POST:UPDATE_PHONE_url parameters:@{@"userPhone":model.userPhone,@"password":[self.PwdTF.text encryptAESWithkey:[UIUtils getCurrentTimes]]} success:^(id result){
                     DLog(@"%@",result);
                      ShowMessage(@"验证成功");
                     NewPhoneViewController *PCVC=[NewPhoneViewController new];
                      [self.navigationController pushViewController:PCVC animated:YES];
                  } failure:^(NSError *error) {

                 }];
        }else
        {
           ShowMessage(@"请输入密码");
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
