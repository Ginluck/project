//
//  CitangCell.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/8.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "TPBaseTableViewCell.h"
#import "CitangListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CitangCell : TPBaseTableViewCell
@property(nonatomic,weak)IBOutlet UIImageView * familyImage;
@property(nonatomic,weak)IBOutlet UILabel * familyName;
@property(nonatomic,weak)IBOutlet UILabel * familyDesc;
@property(nonatomic,weak)IBOutlet UILabel * familyId;
@property(nonatomic,weak)IBOutlet UIView * shaDowView;
@property(nonatomic,weak)IBOutlet UIView * bgView;

-(void)reloadCell:(CitangListModel*)model;
@end

NS_ASSUME_NONNULL_END
