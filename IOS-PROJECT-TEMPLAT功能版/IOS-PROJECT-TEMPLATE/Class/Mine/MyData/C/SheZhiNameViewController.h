//
//  SheZhiNameViewController.h
//  RentHouseApp
//
//  Created by Apple on 2019/6/3.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "TPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SheZhiNameViewController : TPBaseViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *NavHeight;
@property (weak, nonatomic) IBOutlet UIView *NavView;
@property (strong, nonatomic)NSString *NameStr;
@end

NS_ASSUME_NONNULL_END
