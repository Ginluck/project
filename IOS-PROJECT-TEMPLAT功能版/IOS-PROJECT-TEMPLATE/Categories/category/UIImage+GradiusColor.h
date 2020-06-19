//
//  UIImage+GradiusColor.h
//  路丫租车-三期
//
//  Created by ginluck on 2018/9/21.
//  Copyright © 2018年 ginluck. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, GradientType) {
    
    GradientTypeTopToBottom = 0,//从上到小
    
    GradientTypeLeftToRight = 1,//从左到右
    
    GradientTypeUpleftToLowright = 2,//左上到右下
    
    GradientTypeUprightToLowleft = 3,//右上到左下
    
};


NS_ASSUME_NONNULL_BEGIN

@interface UIImage(GradiusColor)
+ (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize;




@end

NS_ASSUME_NONNULL_END
