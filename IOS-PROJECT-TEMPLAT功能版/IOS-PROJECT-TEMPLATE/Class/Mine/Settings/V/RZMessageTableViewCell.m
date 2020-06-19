//
//  RZMessageTableViewCell.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/22.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "RZMessageTableViewCell.h"

@implementation RZMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(RZMessageModel *)model type:(nonnull NSString *)type
{
    if ([type isEqualToString:@"2"]) {
        self.nameLab.text=[NSString stringWithFormat:@"家族名：%@",model.name];
    }
    else
    {
         self.nameLab.text=[NSString stringWithFormat:@"申请人：%@",model.real_name];
    }
    self.timeLab.text=[NSString stringWithFormat:@"申请时间：%@",model.createTime];
    switch ([model.state intValue]) {
        case 0:
        {
            self.stateLab.text=@"申请查看";
        }
            break;
            case 1:
                   {
                       self.stateLab.text=@"申请查看通过";
                   }
                       break;
            case 2:
                   {
                       self.stateLab.text=@"申请驳回";
                   }
                       break;
            case 3:
                              {
                                  self.stateLab.text=@"申请族谱";
                              }
                                  break;
            case 4:
                              {
                                  self.stateLab.text=@"已加入族谱";
                              }
                                  break;
            case 5:
            {
                self.stateLab.text=@"申请确认自己";
            }
                break;
            
        default:
            break;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
