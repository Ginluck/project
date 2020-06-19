//
//  AboutMeViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/8.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "AboutMeViewController.h"
#import "UserAgreementViewController.h"
#import "MyIntroduceViewController.h"
@interface AboutMeViewController ()

@end

@implementation AboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)GongNeng:(id)sender {
    MyIntroduceViewController *UAVC=[MyIntroduceViewController new];
       [self.navigationController pushViewController:UAVC animated:YES];
}
- (IBAction)Agreement:(id)sender {
    UserAgreementViewController *UAVC=[UserAgreementViewController new];
    [self.navigationController pushViewController:UAVC animated:YES];
}
- (IBAction)Verson:(id)sender {
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
