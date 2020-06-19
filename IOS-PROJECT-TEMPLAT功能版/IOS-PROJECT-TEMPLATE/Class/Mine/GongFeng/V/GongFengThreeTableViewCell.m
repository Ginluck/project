//
//  GongFengThreeTableViewCell.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/11.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "GongFengThreeTableViewCell.h"

@implementation GongFengThreeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(GongFengListModel *)model
{
    [self.Img sd_setImageWithURL:[NSURL URLWithString:model.jpImgUrl] placeholderImage:[UIImage imageNamed:@"商品占位图"]];
    self.name.text=model.jpName;
    self.ColorLab.text=model.jpMoral;
    self.DaysLab.text=[NSString stringWithFormat:@"到期时间%@",model.beOverdueTime];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
