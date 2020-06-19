//
//  JipinView.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/12.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "JipinView.h"
@interface JipinView()


@end
@implementation JipinView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



-(instancetype)initWithFrame:(CGRect)frame
{
    if (self ==[super initWithFrame:frame])
    {
        [self addSubview:self.proImage];
        [self addSubview:self.topLab];
        [self addSubview:self.bottomLab];
        [self addSubview:self.clickBtn];
        self.backgroundColor =[UIColor clearColor];
    }
    return self;
}


-(UIImageView *)proImage
{
    if (!_proImage)
    {
        _proImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.frame.size.width, self.frame.size.width)];
        _proImage.backgroundColor =[UIColor clearColor];
        _proImage.contentMode =UIViewContentModeScaleAspectFit;
    }
    return _proImage;
}

-(UILabel *)topLab
{
    if (!_topLab)
    {
        _topLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
        [_topLab setFont:MKFont(14)];
        _topLab.textColor =[UIColor whiteColor];
        _topLab.textAlignment =NSTextAlignmentCenter;
        _topLab.backgroundColor =[UIColor clearColor];
    }
    return _topLab;
}

-(JPButton *)clickBtn
{
    if (!_clickBtn) {
        _clickBtn =[JPButton buttonWithType:UIButtonTypeCustom];
        _clickBtn.frame =self.bounds;
        _clickBtn.backgroundColor =[UIColor clearColor];
    }
    return _clickBtn;
    
}
-(UILabel *)bottomLab
{
    if (!_bottomLab)
    {
        _bottomLab =[[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.width+20, self.frame.size.width, 15)];
        [_bottomLab setFont:MKFont(12)];
        _bottomLab.textColor =[UIColor whiteColor];
        _bottomLab.textAlignment =NSTextAlignmentCenter;
        _bottomLab .backgroundColor =[UIColor clearColor];
    }
    return _bottomLab;
}
@end
@implementation JPButton

@synthesize row;

@end
