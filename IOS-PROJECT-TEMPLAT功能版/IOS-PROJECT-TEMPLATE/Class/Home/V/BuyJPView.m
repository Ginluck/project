//
//  BuyJPView.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/25.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "BuyJPView.h"
@interface BuyJPView()
@property(nonatomic,weak)IBOutlet UIImageView *JPImage;
@property(nonatomic,weak)IBOutlet UILabel *JPName;
@property(nonatomic,weak)IBOutlet UILabel *JPPrice;
@property(nonatomic,weak)IBOutlet UILabel *JPYuYi;
@property(nonatomic,weak)IBOutlet UILabel *JPTime;
@property(nonatomic,strong)NSString *JPTimeStr;
@property(nonatomic,weak)IBOutlet UITextField *JPCount;
@property(nonatomic,strong) JipinChild *model;
@end
@implementation BuyJPView

-(IBAction)btnClick:(UIButton *)sender
{
    NSString * text  =self.JPCount.text ;
    NSInteger value = [text integerValue];
    if (sender.tag==10)
    {
        value =value -1;
        if (value<0)
        {
            value =0;
        }
    }
    else
    {
        value =value+1;
    }
    self.JPCount.text =[NSString stringWithFormat:@"%ld",(long)value];
    self.JPPrice.text =[NSString stringWithFormat:@"%ld",[_model.price integerValue]*value];
    self.JPTime.text =[NSString stringWithFormat:@"时间:%ld天",[_model.useLength integerValue] * value];
    self.JPTimeStr=[NSString stringWithFormat:@"%ld",[_model.useLength integerValue] * value];
}


-(IBAction)actionClick:(UIButton *)sender
{
    if (sender.tag ==11)
    {
        if (self.delegate) {
          
            [self.delegate buyViewDelegate:sender time:self.JPTimeStr amount:self.JPPrice.text pro:_model.id count:self.JPCount.text model:self.model];
        }
    }
    else
    {
        [self removeFromSuperview];
    }
 
}

-(void)refreshUI:(JipinChild *)model
{
    _model =model;
    [self.JPImage sd_setImageWithURL:[NSURL URLWithString:_model.imgUrl]];
    self.JPName.text =_model.name;
    self.JPPrice.text =_model.price;
    self.JPTime.text =[NSString stringWithFormat:@"时间:%@天",_model.useLength];
    self.JPYuYi.text =[NSString stringWithFormat:@"寓意:%@",_model.moral];
    self.JPTimeStr =_model.useLength;
    
}
@end
