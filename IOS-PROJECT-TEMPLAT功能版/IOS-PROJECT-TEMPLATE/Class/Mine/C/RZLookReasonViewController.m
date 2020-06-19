//
//  RZLookReasonViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/22.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "RZLookReasonViewController.h"
@interface RZLookReasonViewController ()

@end

@implementation RZLookReasonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitleView:@"查看原因"];
     UserModel * model =[[UserManager shareInstance]getUser];
    switch ([self.model.state intValue]) {
                 case 0:
                 {
                     self.Lab1.text=@"申请原因:";
                     self.Reason.text=self.model.reason;
                     if ([model.patriarch isEqualToString:@"1"]&&[self.TypeStr isEqualToString:@"1"]) {
                         self.TGBtn.alpha=1;
                         self.BHBtn.alpha=1;
                     }else
                     {
                         self.TGBtn.alpha=0;
                         self.BHBtn.alpha=0;
                     }
                    
                 }
                     break;
                     case 1:
                            {
                               self.Lab1.text=@"申请原因:";
                               self.Reason.text=self.model.reason;
                               self.TGBtn.alpha=0;
                               self.BHBtn.alpha=0;
                            }
                                break;
                     case 2:
                            {
                                self.Lab1.text=@"驳回原因:";
                                self.Reason.text=self.model.rejectReason;
                                self.TGBtn.alpha=0;
                                self.BHBtn.alpha=0;
                            }
                                break;
            case 3:
                                       {
                                           self.Lab1.text=@"申请原因:";
                                           self.Reason.text=self.model.reason;
                                           if ([model.patriarch isEqualToString:@"1"]&&[self.TypeStr isEqualToString:@"1"]) {
                                               self.TGBtn.alpha=1;
                                               self.BHBtn.alpha=1;
                                           }else
                                           {
                                               self.TGBtn.alpha=0;
                                               self.BHBtn.alpha=0;
                                           }
                                          
                                       }
                                           break;
            case 5:
                                                 {
                                                     self.Lab1.text=@"申请原因:";
                                                     self.Reason.text=self.model.reason;
                                                     if ([self.TypeStr isEqualToString:@"1"]) {
                                                         self.TGBtn.alpha=1;
                                                         self.BHBtn.alpha=1;
                                                     }else
                                                     {
                                                         self.TGBtn.alpha=0;
                                                         self.BHBtn.alpha=0;
                                                     }
                                                    
                                                 }
                                                     break;



                 default:
                     break;
             }
    [self.TGBtn addTarget:self action:@selector(TGClick) forControlEvents:UIControlEventTouchUpInside];
    [self.BHBtn addTarget:self action:@selector(BHClick) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
}
-(void)TGClick
{
    if ([self.model.state isEqualToString:@"3"]) {
        [RequestHelp POST:update_url parameters:@{@"id":self.model.id,@"state":@"4",@"zpId":self.model.zp_id,@"isSh":@"0"} success:^(id result) {
               ShowMessage(@"操作成功");
               [self.navigationController popViewControllerAnimated:YES];
           } failure:^(NSError *error) {
              
           }];
    }else if ([self.model.state isEqualToString:@"5"])
    {
        [RequestHelp POST:update_url parameters:@{@"id":self.model.id,@"state":@"4"} success:^(id result) {
                   ShowMessage(@"操作成功");
                   [self.navigationController popViewControllerAnimated:YES];
               } failure:^(NSError *error) {
                  
               }];
    }
    else
    {
        [RequestHelp POST:update_url parameters:@{@"id":self.model.id,@"state":@"1"} success:^(id result) {
            ShowMessage(@"操作成功");
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
           
        }];
    }
   
}
-(void)BHClick
{
 //驳回
                        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"请填写驳回原因" preferredStyle:(UIAlertControllerStyleAlert)];
                        
                        [alertView addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                            
            //                textField.keyboardType = UIKeyboardTypeNumberPad;
                            
                            textField.placeholder = @"请填写驳回原因";
                            
                        }];
                        
                        UIAlertAction *alertText = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                            
                            UITextField *textFieldUser = [[alertView textFields] firstObject];
                            
                            if (textFieldUser.text.length == 0)
                            {
                                ShowMessage(@"请填写驳回原因");return ;
                            }
                            
                           
                            
                            [RequestHelp POST:update_url parameters:@{@"id":self.model.id,@"state":@"2",@"rejectReason":textFieldUser.text} success:^(id result) {
                                ShowMessage(@"操作成功");
                                [self.navigationController popViewControllerAnimated:YES];
                            } failure:^(NSError *error) {
                               
                            }];
                        }];
                        
                        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                        }];
                        
                        [alertView addAction:cancleAction];
                        
                        [alertView addAction:alertText];
                        
                        [self presentViewController:alertView animated:YES completion:nil];
               
            
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
