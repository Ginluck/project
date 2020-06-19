//
//  GongFengOneTableViewCell.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/11.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "GongFengOneTableViewCell.h"

@implementation GongFengOneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(GongFengListModel *)model
{
    [self.Img sd_setImageWithURL:[NSURL URLWithString:model.jpImgUrl] placeholderImage:[UIImage imageNamed:@"商品占位图"]];
    self.name.text=model.jpName;
    self.ColorLab.text=model.jpMoral;
    self.DaysLab.text=[NSString stringWithFormat:@"数量:%@ 单个时长%@天",model.count,model.singleLength];
     self.time.text=[NSString stringWithFormat:@"到期时间%@",model.beOverdueTime];
    self.ColorLab.text=model.ctName;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
