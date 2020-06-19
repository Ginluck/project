//
//  MemberDetailGuanxiCell.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/9.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemberDetailChild.h"
NS_ASSUME_NONNULL_BEGIN

@interface MemberDetailGuanxiCell : UICollectionViewCell
-(void)refreshCell:(MemberDetailChild*)model;
@end

NS_ASSUME_NONNULL_END
