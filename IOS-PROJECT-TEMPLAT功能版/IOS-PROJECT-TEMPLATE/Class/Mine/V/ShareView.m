//
//  ShareView.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/6/11.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "ShareView.h"

@implementation ShareView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(IBAction)btnClick:(UIButton *)sender
{
    if (self.delegate)
    {
        [self.delegate shareViewBtnClick:sender];
    }
}
@end
