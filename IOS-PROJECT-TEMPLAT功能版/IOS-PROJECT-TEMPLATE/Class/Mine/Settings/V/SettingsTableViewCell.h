//
//  SettingsTableViewCell.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/8.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "TPBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettingsTableViewCell : TPBaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Img;
@property (weak, nonatomic) IBOutlet UILabel *Lab;
@property (weak, nonatomic) IBOutlet UILabel *line;

@end

NS_ASSUME_NONNULL_END
