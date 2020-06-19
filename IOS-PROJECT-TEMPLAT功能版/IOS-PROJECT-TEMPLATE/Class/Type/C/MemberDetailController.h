//
//  MemberDetailController.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/9.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "TPBaseViewController.h"
#import "FamilyTreeMember.h"
NS_ASSUME_NONNULL_BEGIN

@interface MemberDetailController : TPBaseViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *KNavHeight;
@property (weak, nonatomic) IBOutlet UIView *KNavView;
@property(nonatomic,strong)FamilyTreeMember * member;
@end

NS_ASSUME_NONNULL_END
