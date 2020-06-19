//
//  ApplyController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/22.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "ApplyController.h"

@interface ApplyController ()
@property(nonatomic,weak)IBOutlet UITextView * contentTV;

@end

@implementation ApplyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)ApplyClick:(id)sender
{
    UserModel * model =[[UserManager shareInstance]getUser];
    if (!self.contentTV.text.length)
    {
        ShowMessage(@"请输入申请原因");
    }
    NSDictionary * param =@{@"userUserId":model.id,@"jzId":self.model.id,@"reason":self.contentTV.text};
    [RequestHelp POST:JS_APPLYZP_URL parameters:param success:^(id result) {
        ShowMessage(@"申请成功");
        [self.navigationController popToRootViewControllerAnimated:YES];
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
