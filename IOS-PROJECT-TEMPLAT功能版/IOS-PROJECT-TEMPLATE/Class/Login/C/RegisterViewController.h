//
//  RegisterViewController.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/7.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "TPBaseViewController.h"
#import "JKCountDownButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface RegisterViewController : TPBaseViewController
@property (weak, nonatomic) IBOutlet UIView *NumberView;
@property (weak, nonatomic) IBOutlet UITextField *NumberTF;
@property (weak, nonatomic) IBOutlet UIView *PwdView;
@property (weak, nonatomic) IBOutlet UITextField *PwdTF;
@property (weak, nonatomic) IBOutlet UIView *CodeView;
@property (weak, nonatomic) IBOutlet UITextField *CodeTF;
@property (weak, nonatomic) IBOutlet JKCountDownButton *CodeBtn;
@property (weak, nonatomic) IBOutlet UILabel *xieyiLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *NavHeight;
@property (weak, nonatomic) IBOutlet UIView *NavView;
@property (weak, nonatomic) IBOutlet UIButton *LoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *XieYiBtn;
@end

NS_ASSUME_NONNULL_END
