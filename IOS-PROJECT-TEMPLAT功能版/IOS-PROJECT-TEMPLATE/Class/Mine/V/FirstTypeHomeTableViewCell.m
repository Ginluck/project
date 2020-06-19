//
//  FirstTypeHomeTableViewCell.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/6/12.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "FirstTypeHomeTableViewCell.h"

@implementation FirstTypeHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)reloadCell:(FamilyListModel *)model
{
    self.nameLabel.text =model.name;
    self.nameIntro.text =model.name;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"共修入%@人",model.jzNum]];
    NSRange range1 = [[str string] rangeOfString:@"共修入"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
    NSRange range2 = [[str string] rangeOfString:[NSString stringWithFormat:@"%@",model.jzNum]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range2];
    NSRange range3 = [[str string] rangeOfString:@"人"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range3];
    self.familyCount.attributedText = str;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
