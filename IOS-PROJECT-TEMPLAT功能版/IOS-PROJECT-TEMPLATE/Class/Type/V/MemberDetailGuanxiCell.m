//
//  MemberDetailGuanxiCell.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/9.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "MemberDetailGuanxiCell.h"
@interface MemberDetailGuanxiCell()
@property(nonatomic,weak)IBOutlet UILabel * name;
@property(nonatomic,weak)IBOutlet UIImageView * headImage;
@property(nonatomic,weak)IBOutlet UILabel * desc;
@end
@implementation MemberDetailGuanxiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)refreshCell:(MemberDetailChild*)model
{
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.headAddress] placeholderImage:KImageNamed(@"临时占位图")];
    self.name.text =model.name;
    self.desc.text =model.introduce;
}

@end
