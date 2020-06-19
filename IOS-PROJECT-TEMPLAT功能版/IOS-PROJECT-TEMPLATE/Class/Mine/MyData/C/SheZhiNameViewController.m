//
//  SheZhiNameViewController.m
//  RentHouseApp
//
//  Created by Apple on 2019/6/3.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "SheZhiNameViewController.h"

@interface SheZhiNameViewController ()
@property(nonatomic,weak)IBOutlet UITextField * nickNameField;
@end

@implementation SheZhiNameViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self hideNavigationBar:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self hideNavigationBar:NO animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.NavHeight.constant =kNavagationBarH;
    [self.NavView setNeedsLayout];
    self.nickNameField.text =self.NameStr;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)Back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)saveBtnClick:(UIButton *)sender
{
    if (!self.nickNameField.text.length) {
        ShowMessage(@"请输入昵称");
        return;
    }
  
  UserModel * model =[[UserManager shareInstance]getUser];
NSDictionary* param_dic =@{@"userPhone":model.userPhone,@"realName":self.nickNameField.text,@"address":@"",@"headAddress":@""};
[RequestHelp POST:UPDATE_ZJ_url parameters:param_dic success:^(id result) {
    MKLog(@"%@",result);
   ShowMessage(@"修改成功");
    [self.navigationController popViewControllerAnimated:YES];
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
