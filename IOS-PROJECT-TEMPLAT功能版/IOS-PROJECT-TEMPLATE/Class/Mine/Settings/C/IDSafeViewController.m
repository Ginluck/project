//
//  IDSafeViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/8.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "IDSafeViewController.h"
#import "PhoneChangeViewController.h"
#import "ChangePwdViewController.h"
@interface IDSafeViewController ()

@end

@implementation IDSafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self addNavigationTitleView:@"账户安全"];
    UserModel * model =[[UserManager shareInstance]getUser];
    self.PhoneLab.text=model.userPhone;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)BDPhone:(id)sender {
    PhoneChangeViewController *PCVC=[PhoneChangeViewController new];
    [self.navigationController pushViewController:PCVC animated:YES];
}
- (IBAction)ChangPwd:(id)sender {
    ChangePwdViewController *PCVC=[ChangePwdViewController new];
    [self.navigationController pushViewController:PCVC animated:YES];
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
