//
//  ChoosePayViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/12.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "ChoosePayViewController.h"

@interface ChoosePayViewController ()

@end

@implementation ChoosePayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)wxClick:(UIButton *)sender {
    [self.wxBtn setImage:KImageNamed(@"蓝勾") forState:UIControlStateNormal];
    [self.aliBtn setImage:KImageNamed(@"灰圈") forState:UIControlStateNormal];
    
}
- (IBAction)AliClick:(UIButton *)sender {
    [self.aliBtn setImage:KImageNamed(@"蓝勾") forState:UIControlStateNormal];
       [self.wxBtn setImage:KImageNamed(@"灰圈") forState:UIControlStateNormal];
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
