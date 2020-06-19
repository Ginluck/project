//
//  LineView.h
//  WXQDrawRect
//
//  Created by WXQ on 2018/8/10.
//  Copyright © 2018年 JingBei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineView : UIView
-(instancetype)initWithFrame:(CGRect)frame point1:(CGPoint)point1 point2:(CGPoint)point2;
- (void)firstDrawStraightLineWithRect:(CGPoint)point1 point2:(CGPoint)point;
@end
