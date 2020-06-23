//
//  MoneyCell.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/6/11.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "TPBaseTableViewCell.h"
#import "HongBaoView.h"
#import "CalendarView.h"
#import "SignModel.h"
#import "NSDate+CommonDate.h"
NS_ASSUME_NONNULL_BEGIN
@protocol moneyCellDelegate <NSObject>

-(void)moneyBtnClick:(UIButton *)sender;

-(void)signBtnClick:(UIButton *)sender;

@end
@interface MoneyCell : TPBaseTableViewCell
@property(nonatomic,weak)IBOutlet UIView * hongBaoView;
@property(nonatomic,weak)IBOutlet UILabel * moneyLabel;
@property(nonatomic,weak)IBOutlet UILabel * signLabel;
@property(nonatomic,weak)IBOutlet UIButton * signButton;
@property(nonatomic,weak)IBOutlet UIView * calendarView;
@property(nonatomic,assign)id<moneyCellDelegate>delegate;
@property(nonatomic,strong)CalendarView  * cView;
-(void)reloadCell:(SignModel * )model;
@end

NS_ASSUME_NONNULL_END
