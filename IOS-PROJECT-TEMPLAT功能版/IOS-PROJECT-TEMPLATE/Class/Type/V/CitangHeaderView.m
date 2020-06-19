//
//  CitangHeaderView.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/15.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "CitangHeaderView.h"

@implementation CitangHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.height.constant =Screen_Width * 256/1034;
}
@end
