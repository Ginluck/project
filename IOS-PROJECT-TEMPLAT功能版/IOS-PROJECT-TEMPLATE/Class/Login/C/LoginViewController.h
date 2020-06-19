//
//  LoginViewController.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2019/12/10.
//  Copyright © 2019年 梦境网络. All rights reserved.
//

#import "TPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : TPBaseViewController
@property (weak, nonatomic) IBOutlet UIView *NumberView;
@property (weak, nonatomic) IBOutlet UITextField *NumberTF;
@property (weak, nonatomic) IBOutlet UIView *PwdView;
@property (weak, nonatomic) IBOutlet UITextField *PwdTF;
@property (weak, nonatomic) IBOutlet UIButton *LoginBtn;

@end

NS_ASSUME_NONNULL_END
