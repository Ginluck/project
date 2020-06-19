//
//  GongpinController.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/12.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "TPBaseViewController.h"
#import "JipinModel.h"
#import "CitangListModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^SelectedItem1Block)(JipinChild *model);
@interface GongpinController : TPBaseViewController
@property (nonatomic, copy) SelectedItem1Block block;
@property(strong,nonatomic)CitangListModel* model;
@end

NS_ASSUME_NONNULL_END
