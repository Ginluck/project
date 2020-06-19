//
//  GongFengThreeTableViewCell.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/11.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "TPBaseTableViewCell.h"
#import "GongFengListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GongFengThreeTableViewCell : TPBaseTableViewCell
@property(nonatomic,strong)GongFengListModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *Img;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *ColorLab;
@property (weak, nonatomic) IBOutlet UILabel *DaysLab;
@property (weak, nonatomic) IBOutlet UIButton *GoBtn;
@property (weak, nonatomic) IBOutlet UILabel *Time;
@end

NS_ASSUME_NONNULL_END
