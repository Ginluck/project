//
//  CitangCell.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/8.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "CitangCell.h"

@implementation CitangCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.cornerRadius =5.f;
    self.bgView.layer.masksToBounds=YES;
    
    
    self.shaDowView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.shaDowView.layer.shadowRadius = 3.0f;
    self.shaDowView.layer.shadowOffset = CGSizeMake(1, 1);
    self.shaDowView.layer.shadowOpacity = .5;
}
-(void)reloadCell:(CitangListModel*)model
{
    [self.familyImage sd_setImageWithURL:[NSURL URLWithString:model.img]];
    self.familyName.text =model.name;
    self.familyDesc.text =model.ctJs;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
