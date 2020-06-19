//
//  FirstTypeHomeTableViewCell.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/6/12.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "TPBaseTableViewCell.h"
#import "FamilyListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FirstTypeHomeTableViewCell : TPBaseTableViewCell
@property(nonatomic,weak)IBOutlet UILabel * nameLabel;
@property(nonatomic,weak)IBOutlet UILabel * familyCount;
@property(nonatomic,weak)IBOutlet UILabel * nameIntro;
@property(nonatomic,weak)IBOutlet UIButton * detailButton;
-(void)reloadCell:(FamilyListModel *)model;
@end

NS_ASSUME_NONNULL_END
