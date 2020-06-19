//
//  HomeHeaderView.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/7.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "HomeHeaderView.h"
#import "CusPageControlWithView.h"
@interface HomeHeaderView()<UIAlertViewDelegate>

{
    CusPageControlWithView *pageView;
   
    
}
@end
@implementation HomeHeaderView
-(IBAction)btnClick:(UIButton *)sender
{
    if (self.delegate) {
        [self.delegate headerViewClick:sender];
    }
}
@end
