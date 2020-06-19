//
//  OpinionFeedBackView.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/6/18.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "OpinionFeedBackView.h"
@interface OpinionFeedBackView()


@end
@implementation OpinionFeedBackView




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
