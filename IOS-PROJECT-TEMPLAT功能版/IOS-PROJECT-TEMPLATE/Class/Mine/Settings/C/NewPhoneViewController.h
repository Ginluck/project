//
//  NewPhoneViewController.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/9.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "TPBaseViewController.h"
#import "JKCountDownButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface NewPhoneViewController : TPBaseViewController
@property (weak, nonatomic) IBOutlet UITextField *PhoneTF;
@property (weak, nonatomic) IBOutlet JKCountDownButton *CodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *CodeTF;
@end

NS_ASSUME_NONNULL_END
