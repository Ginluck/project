//
//  ChangePwdViewController.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/9.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "TPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChangePwdViewController : TPBaseViewController
@property (weak, nonatomic) IBOutlet UITextField *OldTF;
@property (weak, nonatomic) IBOutlet UITextField *NewTF;
@property (weak, nonatomic) IBOutlet UITextField *AgainTF;

@end

NS_ASSUME_NONNULL_END
