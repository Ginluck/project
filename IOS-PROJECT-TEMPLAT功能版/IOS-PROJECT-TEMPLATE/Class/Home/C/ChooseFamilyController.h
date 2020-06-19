//
//  ChooseFamilyController.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/28.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "TPBaseViewController.h"
#import "FamilyListModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^SelectedFamilyBlock)(FamilyListModel *model);
@interface ChooseFamilyController : TPBaseViewController
@property (nonatomic, copy) SelectedFamilyBlock block;
@end

NS_ASSUME_NONNULL_END
