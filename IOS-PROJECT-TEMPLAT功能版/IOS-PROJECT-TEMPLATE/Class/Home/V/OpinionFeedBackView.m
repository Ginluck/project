//
//  OpinionFeedBackView.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/6/18.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "OpinionFeedBackView.h"
#import "UITextView+WJPlaceholder.h"
@interface OpinionFeedBackView()


@end
@implementation OpinionFeedBackView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.feedView =[[UITextView alloc]initWithFrame:CGRectMake(8, 33, 224, 140)];
    self.feedView.placeholdFont =MKFont(13);
    self.feedView.placeholderColor =[UIColor lightGrayColor];
    self.feedView.placeholder =@"请输入您要反馈的建议";
    self.feedView.layer.borderWidth =1.f;
    self.feedView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.feedView.layer.cornerRadius =5.f;
    self.feedView.layer.masksToBounds =YES;
    [self addSubview:self.feedView];
}


-(IBAction)click:(UIButton*)sender
{
    if (self.delegate) {
        [self.delegate opinionViewClick:sender];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
