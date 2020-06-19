//
//  GusetChooseCityTableViewCell.m
//  HouseAssistantAPP
//
//  Created by Apple on 2019/7/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "GusetChooseCityTableViewCell.h"

@implementation GusetChooseCityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(HelpHouseCityModel *)model
{
    self.NameTable.text=model.name;
} 
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
      [super setSelected:selected animated:animated];
    if (selected) {
        self.NameTable.textColor = K_Prokect_MainColor;
    }else
    {
        self.NameTable.textColor = [UIColor darkTextColor];
    }
    self.highlighted = selected;
    // Configure the view for the selected state
}

@end
