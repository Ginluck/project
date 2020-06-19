//
//  XunzuCell.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/7.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "XunzuCell.h"
@interface XunzuCell()
@property(nonatomic,weak)IBOutlet UILabel * familyName;
@property(nonatomic,weak)IBOutlet UILabel * familyDesc;
@property(nonatomic,weak)IBOutlet UIImageView * familyHeaderImage;
@end
@implementation XunzuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
