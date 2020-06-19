//
//  NSString+Fit.m
//  NTCM
//
//  Created by cooptec on 2017/5/17.
//  Copyright © 2017年 Law. All rights reserved.
//

#import "NSString+Fit.h"

@implementation NSString (Fit)
- (CGFloat)getWidthWithFont:(CGFloat)font
{
    UIFont *textFont = [UIFont systemFontOfSize:font];
    NSDictionary *dic = @{NSFontAttributeName : textFont};
    CGSize max_Size = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    CGSize afterSize = [self boundingRectWithSize:max_Size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return afterSize.width;
    
}
- (CGFloat)getHeightWithFont:(CGFloat)font withWidth:(CGFloat)width
{
    UIFont *textFont = [UIFont systemFontOfSize:font];

    NSDictionary *dic = @{NSFontAttributeName : textFont};
    
    CGSize max_Size = CGSizeMake(width, CGFLOAT_MAX);
    CGSize afterSize = [self boundingRectWithSize:max_Size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return afterSize.height;
}
- (CGFloat)getSpaceLabelHeightWithFont:(CGFloat)font withWidth:(CGFloat)width withLineSpace:(CGFloat)lineSpace {
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    paraStyle.alignment = NSTextAlignmentLeft;
    
    paraStyle.lineSpacing = lineSpace;
    
    paraStyle.hyphenationFactor = 1.0;
    
    paraStyle.firstLineHeadIndent = 0.0;
    
    paraStyle.paragraphSpacingBefore = 0.0;
    
    paraStyle.headIndent = 0;
    
    paraStyle.tailIndent = 0;
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font], NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size.height;
    
}
@end
