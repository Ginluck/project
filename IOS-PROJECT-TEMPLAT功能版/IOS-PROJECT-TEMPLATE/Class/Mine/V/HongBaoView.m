//
//  HongBaoView.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/6/11.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "HongBaoView.h"

@implementation HongBaoView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self ==[super initWithFrame:frame])
    {
        self.frame =frame;
        [self addSubview:self.action];
        [self addSubview:self.days];
    }
    return self;
}

-(UIButton *)action
{
    if (!_action)
    {
        _action =[UIButton buttonWithType:UIButtonTypeCustom];
        [_action setImage:KImageNamed(@"红包") forState:UIControlStateNormal];
        _action.frame =CGRectMake(0, 0, 40, 50);
        _action.contentMode =UIViewContentModeScaleAspectFit;
    }
    return _action;
}

-(UILabel *)days
{
    if (!_days)
    {
        _days =[[UILabel alloc]initWithFrame:CGRectMake(0, 50, 40, 20)];
        _days.font =MKFont(11);
        _days.textColor =[UIColor darkGrayColor];
        _days.textAlignment =NSTextAlignmentCenter;
    }
    return _days;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
