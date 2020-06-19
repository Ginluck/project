//
//  MemberDetailInfoCell.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/9.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "MemberDetailInfoCell.h"
@interface MemberDetailInfoCell()
@property(nonatomic,weak)IBOutlet UILabel * nameLab;
@property(nonatomic,weak)IBOutlet UILabel * sexLab;
@property(nonatomic,weak)IBOutlet UILabel * stateLab;
@property(nonatomic,weak)IBOutlet UILabel * birthLab;
@property(nonatomic,weak)IBOutlet UILabel * deathLab;
@property(nonatomic,weak)IBOutlet UITextView * introTV;
@end
@implementation MemberDetailInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)refresh:(MemberDetailModel*)model
{
    self.nameLab.text =model.name;
    self.sexLab.text =[model.sex isEqualToString:@"0"]?@"男":@"女";
    self.stateLab.text =[model.state isEqualToString:@"0"]?@"在世":@"离世";
    self.birthLab.text =model.birthTime;
    self.deathLab.text =model.deathTime;
    self.introTV.text =model.introduce;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
