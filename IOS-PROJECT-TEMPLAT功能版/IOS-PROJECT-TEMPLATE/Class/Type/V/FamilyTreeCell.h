//
//  FamilyTreeCell.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/7.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "TPBaseTableViewCell.h"
#import "FamilyTreeModel.h"
#import "FamilyTreeMember.h"
@class FamliyTreeButton;
NS_ASSUME_NONNULL_BEGIN
@protocol FamilyCellClickDelegate <NSObject>

-(void)familyBtnClick:(FamliyTreeButton *)button;

@end
@interface FamilyTreeCell : TPBaseTableViewCell
@property(nonatomic,assign)id<FamilyCellClickDelegate>delegate;
-(void)setCell:(NSArray *)ary index:(NSInteger)row;
@end





@interface FamliyTreeButton : UIButton
@property(nonatomic,assign)NSInteger row;
@end
NS_ASSUME_NONNULL_END
