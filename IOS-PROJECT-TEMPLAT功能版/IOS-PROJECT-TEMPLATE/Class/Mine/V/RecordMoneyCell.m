//
//  RecordMoneyCell.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/6/23.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "RecordMoneyCell.h"
@interface RecordMoneyCell()
@property(nonatomic,weak)IBOutlet UILabel * sourceLabel;
@property(nonatomic,weak)IBOutlet UILabel * timeLabel;
@property(nonatomic,weak)IBOutlet UILabel * moneyLabel;
@end
@implementation RecordMoneyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)reloadCell:(RecordChild*)model
{
    self.timeLabel.text =model.updateTime;
    NSString * str ;
   
    switch ([model.type integerValue]) {
        case 0:
        {
            str =@"+";
            self.sourceLabel.text =@"充值";
        }
            break;
        case 1:
        {
             str =@"-";
             self.sourceLabel.text =@"消费";
        }
            break;
        case 2:
        {
             str =@"+";
             self.sourceLabel.text =@"签到";
        }
            break;
        case 3:
        {
             str =@"+";
            self.sourceLabel.text =@"签到额外奖励";
        }
            break;
        case 4:
        {
            str =@"+";
            self.sourceLabel.text =@"邀请奖励";
        }
            break;
        case 5:
        {
            str =@"+";
            self.sourceLabel.text =@"注册赠送";
        }
            break;
            
        default:
            break;
    }
    self.moneyLabel.text =[NSString stringWithFormat:@"%@%@",str,model.amountOfMoney];
}
@end
