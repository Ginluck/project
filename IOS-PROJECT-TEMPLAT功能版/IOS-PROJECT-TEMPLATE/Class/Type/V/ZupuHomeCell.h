//
//  ZupuHomeCell.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/15.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "TPBaseTableViewCell.h"
#import "FamilyListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZupuHomeCell : TPBaseTableViewCell
@property(nonatomic,weak)IBOutlet UIButton * detailButton;
-(void)reloadCell:(FamilyListModel *)model;
@end

NS_ASSUME_NONNULL_END
