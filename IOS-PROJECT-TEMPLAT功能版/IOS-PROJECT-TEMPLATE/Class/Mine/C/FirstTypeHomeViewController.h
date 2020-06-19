//
//  FirstTypeHomeViewController.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/6/12.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "TPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^ViewClickBlock)(NSInteger index);
@interface FirstTypeHomeViewController : TPBaseViewController
@property(nonatomic,strong)ViewClickBlock VCClick;
@end

NS_ASSUME_NONNULL_END
