//
//  MineHeaderView.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/27.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "MineHeaderView.h"
#import "MineDataModel.h"
@implementation MineHeaderView
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(MineDataModel *)model
{
    [self.HeadImg sd_setImageWithURL:[NSURL URLWithString:model.headAddress] placeholderImage:[UIImage imageNamed:@"临时占位图"]];
               self.PhoneLab.text=model.userPhone;
              self.NameLab.text=model.realName;
}
- (IBAction)BtnClick:(UIButton *)sender {
    if (self.VCClick) {
        self.VCClick(sender.tag-10);
    }
    
}
@end
