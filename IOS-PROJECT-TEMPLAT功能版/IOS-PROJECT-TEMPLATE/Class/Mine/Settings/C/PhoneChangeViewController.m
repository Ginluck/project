//
//  PhoneChangeViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/9.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "PhoneChangeViewController.h"
#import "IDConfirmViewController.h"
@interface PhoneChangeViewController ()

@end

@implementation PhoneChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitleView:@"绑定手机"];
    UserModel * model =[[UserManager shareInstance]getUser];
    self.PhoneLab.text=model.userPhone;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)Change:(id)sender {
    IDConfirmViewController *PCVC=[IDConfirmViewController new];
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
