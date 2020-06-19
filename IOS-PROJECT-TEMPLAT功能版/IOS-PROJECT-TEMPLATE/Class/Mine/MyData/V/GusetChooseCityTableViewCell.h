//
//  GusetChooseCityTableViewCell.h
//  HouseAssistantAPP
//
//  Created by Apple on 2019/7/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "TPBaseTableViewCell.h"
#import "HelpHouseCityModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GusetChooseCityTableViewCell : TPBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *NameTable;
@property (strong, nonatomic)HelpHouseCityModel *model;
@end

NS_ASSUME_NONNULL_END
