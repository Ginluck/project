//
//  JipinCell.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/12.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "TPBaseTableViewCell.h"
#import "JipinModel.h"
#import "JipinChild.h"
@class JPButton;
NS_ASSUME_NONNULL_BEGIN
@protocol JPCellClickDelegate <NSObject>

-(void)JPCellClick:(JPButton*)button;

@end
@interface JipinCell : TPBaseTableViewCell
@property(nonatomic,assign)id<JPCellClickDelegate>delegate;
-(void)setCell:(NSArray*)list row:(NSInteger)row;
@end

NS_ASSUME_NONNULL_END
