//
//  FamilyLineController.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/7.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "TPBaseViewController.h"
#import "FamilyListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FamilyLineController : TPBaseViewController
@property(nonatomic,strong)NSArray * dataAry;
@property(nonatomic,strong)FamilyListModel * model;

@end

NS_ASSUME_NONNULL_END
