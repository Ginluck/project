//
//  RZLookReasonViewController.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/22.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "TPBaseViewController.h"
#import "RZMessageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RZLookReasonViewController : TPBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *Lab1;
@property (weak, nonatomic) IBOutlet UILabel *Reason;
@property (weak, nonatomic) IBOutlet UIButton *TGBtn;
@property (weak, nonatomic) IBOutlet UIButton *BHBtn;
@property (strong, nonatomic)RZMessageModel *model;
@property (strong, nonatomic)NSString *TypeStr;
@end

NS_ASSUME_NONNULL_END
