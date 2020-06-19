//
//  XingliProController.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/12.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "TPBaseViewController.h"
#import "CitangListModel.h"
#import "JipinModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^SelectedItemBlock)(JipinChild *model);
@interface XingliProController : TPBaseViewController
@property(strong,nonatomic)CitangListModel* model;
@property (nonatomic, copy) SelectedItemBlock block;
@end

NS_ASSUME_NONNULL_END
