//
//  MemberDetailInfoCell.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/9.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "TPBaseTableViewCell.h"
#import "MemberDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MemberDetailInfoCell : TPBaseTableViewCell
-(void)refresh:(MemberDetailModel*)model;
@end

NS_ASSUME_NONNULL_END
