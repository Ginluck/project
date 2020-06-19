//
//  UIView+CornerRdius.m
//  apple
//
//  Created by he on 16/3/29.
//
//

#import "UIView+CornerRdius.h"

#import <objc/runtime.h>

#define TEMP_WIDTH 375.0
#define RATIO (SCREEN_WIDTH/TEMP_WIDTH)
#define SCREEN_SCALE [UIScreen mainScreen].scale
#define SCREEN_WIDTH MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)

@implementation UIView (CornerRdius)

- (CGFloat)cornerRadius
{
    return [objc_getAssociatedObject(self, @selector(cornerRadius)) floatValue];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = (cornerRadius > 0);
}

- (BOOL)avatarCorner{
    return [objc_getAssociatedObject(self, @selector(cornerRadius)) floatValue] > 0;
}

- (void)setAvatarCorner:(BOOL)corner{
    if (corner){
        self.layer.cornerRadius = CGRectGetWidth(self.frame)/2;
        self.layer.masksToBounds = corner;
    }
}

- (CGFloat)borderWidth{
    return [objc_getAssociatedObject(self, @selector(borderWidth)) floatValue];
}

- (void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = (borderWidth > 0);
}


- (UIColor *)borderColor{
    return objc_getAssociatedObject(self, @selector(borderColor));
}

- (void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setLineView:(BOOL)lineView{
    if (lineView){
        CGFloat value = 1/SCREEN_SCALE;
        if (RATIO > 1){
            value = 2/SCREEN_SCALE;
        }
        
        NSLayoutConstraint *constraint = [self.constraints firstObject];
        constraint.constant = value;
    }
    
    objc_setAssociatedObject(self, @"lineView", @(lineView), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isLineView{
    
    return [objc_getAssociatedObject(self, @selector(isLineView)) boolValue];
}

- (void)setLineBorder:(BOOL)lineBorder{
    if (lineBorder){
        self.layer.borderWidth = 1/SCREEN_SCALE;
        self.layer.masksToBounds = YES;
    }
    objc_setAssociatedObject(self, @"lineBorder", @(lineBorder), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isLineBorder{
    
    return [objc_getAssociatedObject(self, @selector(isLineBorder)) boolValue];
}


+ (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize {
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case GradientTypeTopToBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        case GradientTypeLeftToRight:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, 0.0);
            break;
        case GradientTypeUpleftToLowright:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, imgSize.height);
            break;
        case GradientTypeUprightToLowleft:
            start = CGPointMake(imgSize.width, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}


@end
