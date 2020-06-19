//
//  SetHeadViewController.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/13.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "TPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetHeadViewController : TPBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *AddressLab;
@property (weak, nonatomic) IBOutlet UILabel *NumberLab;
@property (weak, nonatomic) IBOutlet UILabel *Namelab;
@property (weak, nonatomic) IBOutlet UIImageView *HeadImg;

@end

NS_ASSUME_NONNULL_END
