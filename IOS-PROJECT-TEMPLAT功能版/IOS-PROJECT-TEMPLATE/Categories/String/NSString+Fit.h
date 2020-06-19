//
//  NSString+Fit.h
//  NTCM
//
//  Created by cooptec on 2017/5/17.
//  Copyright © 2017年 Law. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Fit)
- (CGFloat)getWidthWithFont:(CGFloat)font;
- (CGFloat)getHeightWithFont:(CGFloat)font withWidth:(CGFloat)width;
//计算带有行间距的label高度
- (CGFloat)getSpaceLabelHeightWithFont:(CGFloat)font withWidth:(CGFloat)width withLineSpace:(CGFloat)lineSpace;
@end
