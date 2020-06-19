//
//  ChooseMemberController.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/28.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "TPBaseViewController.h"
#import "FamilyListModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^SelectedMemberBlock)(NSArray *arr);
@interface ChooseMemberController : TPBaseViewController
@property(nonatomic,strong)FamilyListModel * model;
@property (nonatomic, copy) SelectedMemberBlock block;
@property (nonatomic, strong) NSArray*selctedArr;;
@end

NS_ASSUME_NONNULL_END
