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
        switch ([model.state intValue]) {
               case 0:
               {
                   self.stateLab.text=@"申请中";
               }
                   break;
                   case 1:
                          {
                              self.stateLab.text=@"申请通过";
                          }
                              break;
                   case 2:
                          {
                              self.stateLab.text=@"申请驳回";
                          }
                              break;
                   case 3:
                                     {
                                         self.stateLab.text=@"申请加入";
                                     }
                                         break;
                   case 4:
                                     {
                                         self.stateLab.text=@"已加入";
                                     }
                                         break;
                   case 5:
                   {
                       self.stateLab.text=@"确认自己";
                   }
                       break;
                case 6:
                {
                    self.stateLab.text=@"已取消";
                }
                    break;
                   
               default:
                   break;
           }
    }
    else
    {
         self.nameLab.text=[NSString stringWithFormat:@"申请人：%@",model.real_name];
        switch ([model.state intValue]) {
            case 0:
            {
                self.stateLab.text=@"待审核";
            }
                break;
                case 1:
                       {
                           self.stateLab.text=@"审核通过";
                       }
                           break;
                case 2:
                       {
                           self.stateLab.text=@"审核驳回";
                       }
                           break;
                case 3:
                                  {
                                      self.stateLab.text=@"待加入";
                                  }
                                      break;
                case 4:
                                  {
                                      self.stateLab.text=@"已加入";
                                  }
                                      break;
                case 5:
                {
                    self.stateLab.text=@"确认自己";
                }
                    break;
             case 6:
             {
                 self.stateLab.text=@"已取消";
             }
                 break;
                
            default:
                break;
        }
    }
    self.timeLab.text=[NSString stringWithFormat:@"申请时间：%@",model.createTime];
   
    if ([type isEqualToString:@"1"]) {
            self.cencelBtn.alpha=0;
            self.btnWidth.constant=8;
        [self.lookBtn setNeedsLayout];
       }else
       {
           if ([model.state isEqualToString:@"4"]) {
                self.cencelBtn.alpha=0;
               self.btnWidth.constant=8;
               [self.lookBtn setNeedsLayout];
           }else
           {
               self.cencelBtn.alpha=1;
               self.btnWidth.constant=66;
              [self.lookBtn setNeedsLayout];
           }
       }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
