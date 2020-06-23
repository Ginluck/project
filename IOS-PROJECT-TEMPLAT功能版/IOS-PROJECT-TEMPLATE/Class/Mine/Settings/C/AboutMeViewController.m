//
//  AboutMeViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/8.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "AboutMeViewController.h"
#import "PolicyViewController.h"
#import "UserAgreementViewController.h"
#import "MyIntroduceViewController.h"
@interface AboutMeViewController ()
@property(nonatomic,strong)NSString *userAgreement;
@property(nonatomic,strong)NSString *aboutAgreement;
@end

@implementation AboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitleView:@"关于祭念"];
    [self postdata];
    // Do any additional setup after loading the view from its nib.
}
-(void)postdata
{
       [RequestHelp POST:selectByAll_URL parameters:@{} success:^(id result) {
           DLog(@"%@",result);
           self.userAgreement=result[@"userAgreement"];
           self.aboutAgreement=result[@"aboutAgreement"];
       } failure:^(NSError *error) {
           
       }];
}
- (IBAction)GongNeng:(id)sender {
    PolicyViewController *PVC =[PolicyViewController new];
       PVC.UrlStr = self.aboutAgreement;
    [PVC addNavigationTitleView:@"功能介绍"];
    [self.navigationController pushViewController:PVC animated:YES];
}
- (IBAction)Agreement:(id)sender {
     PolicyViewController *PVC =[PolicyViewController new];
          PVC.UrlStr = self.userAgreement;
     [PVC addNavigationTitleView:@"用户协议"];
       [self.navigationController pushViewController:PVC animated:YES];
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
