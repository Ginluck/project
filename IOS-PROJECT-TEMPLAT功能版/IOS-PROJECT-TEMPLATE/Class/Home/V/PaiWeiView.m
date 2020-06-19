//
//  PaiWeiView.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/6/3.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "PaiWeiView.h"

@implementation PaiWeiView




-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame: frame])
    {
        self.frame =frame;
        [self addSubview:[self bgImage]];
        [self addSubview:self.nameLabel];
    }
    return self;
}
-(UIImageView*)bgImage
{
    UIImageView* bgImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    bgImage.image =KImageNamed(@"牌位1");
    return bgImage;
}

-(UILabel*)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/4, self.frame.size.height/2)];
        _nameLabel.center =CGPointMake(self.frame.size.width/2, self.frame.size.height/3+5);
        _nameLabel.textAlignment =NSTextAlignmentCenter;
        _nameLabel.textColor =[UIColor whiteColor];
        _nameLabel.font =MKFont(8);
    }
    return _nameLabel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
