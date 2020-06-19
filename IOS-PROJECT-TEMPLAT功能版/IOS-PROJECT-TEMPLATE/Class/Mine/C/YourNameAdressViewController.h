//
//  YourNameAdressViewController.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/29.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "TPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YourNameAdressViewController : TPBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *AddressLab;
@property (weak, nonatomic) IBOutlet UILabel *NumberLab;
@property (weak, nonatomic) IBOutlet UITextField *Namelab;
@property (weak, nonatomic) IBOutlet UIImageView *HeadImg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *KNavHeight;
@property (weak, nonatomic) IBOutlet UIView *KNavView;
@property (weak, nonatomic) IBOutlet UIView *BgView;
@property (weak, nonatomic) IBOutlet UIButton *SaveBtn;

@end

NS_ASSUME_NONNULL_END
