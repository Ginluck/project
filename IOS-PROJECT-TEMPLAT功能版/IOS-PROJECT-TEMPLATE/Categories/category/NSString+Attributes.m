//
//  NSString+Attributes.m
//  XinJiangTaxiProject
//
//  Created by 陈晨昕 on 2017/7/14.
//  Copyright © 2017年 HeXiulian. All rights reserved.
//

#import "NSString+Attributes.h"

@implementation NSString (Attributes)

-(CGSize )stringSizeWithAttributesFont:(UIFont *)font {

    NSDictionary * attributes = @{NSFontAttributeName : font};
    CGSize size = [self sizeWithAttributes:attributes];
    return size;
}

@end
