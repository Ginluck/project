//
//  AddNewMemberController.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/9.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "TPBaseViewController.h"
#import "FamilyTreeMember.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddNewMemberController : TPBaseViewController
@property(nonatomic,strong)NSString * type;//1.编辑该成员  2.添加上一代  3添加下一代 4
@property(nonatomic,strong)FamilyTreeMember * member;
@end

NS_ASSUME_NONNULL_END
