//
//  RecordMoneyCell.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/6/23.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "TPBaseTableViewCell.h"
#import "RecordModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RecordMoneyCell : TPBaseTableViewCell
-(void)reloadCell:(RecordChild*)model;
@end

NS_ASSUME_NONNULL_END
