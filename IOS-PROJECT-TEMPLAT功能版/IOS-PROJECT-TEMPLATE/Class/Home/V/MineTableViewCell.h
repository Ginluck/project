//
//  MineTableViewCell.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/8.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "TPBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^ViewClickBlock)(NSInteger index);
@interface MineTableViewCell : TPBaseTableViewCell
@property (weak, nonatomic) IBOutlet UIButton *HeaderBtn;
@property (weak, nonatomic) IBOutlet UILabel *NameLab;
@property (weak, nonatomic) IBOutlet UILabel *PhoneLab;
@property (weak, nonatomic) IBOutlet UIImageView *HeadImg;
@property (weak, nonatomic) IBOutlet UIButton *LoginOutBtn;
@property (weak, nonatomic) IBOutlet UILabel *GoldLab;
@property(nonatomic,strong)ViewClickBlock VCClick;

@end

NS_ASSUME_NONNULL_END
