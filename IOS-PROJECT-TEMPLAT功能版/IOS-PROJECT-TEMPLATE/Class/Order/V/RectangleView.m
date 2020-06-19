//
//  RectangleView.m
//  WXQDrawRect
//
//  Created by WXQ on 2018/8/13.
//  Copyright © 2018年 JingBei. All rights reserved.
//

#import "RectangleView.h"

#define K_X   CGRectGetWidth(self.frame)/4
#define K_Y   20
#define K_W  50
#define K_H   15
@interface RectangleView()
@property(nonatomic,assign)CGContextRef  context;
@end
@implementation RectangleView

-(CGContextRef)context
{
    if (!_context) {
        _context =UIGraphicsGetCurrentContext();
    }
    return _context;
}
- (void)drawRect:(CGRect)rect {
    NSLog(@"%@",NSStringFromCGRect(self.frame));
  
    //背景颜色设置
    [[UIColor whiteColor] set];
    CGContextFillRect(self.context, rect);
    //画一个矩形-带边框，无填充
    //边框
    CGContextSetLineWidth(self.context, 1.0);
    CGContextSetStrokeColorWithColor(self.context, [UIColor blackColor].CGColor);
    CGContextStrokeRect(self.context, CGRectMake(0, 0, K_W, K_H));
    
    //方法1 绘制路径及填充模式
    //    CGContextDrawPath(context, kCGPathStroke);
    //方法2 绘制路径
    CGContextStrokePath(self.context);
    [self toDrawTextWithRect:CGRectMake(0, 0, K_W, K_H) str:self.textContent];
  
}


-(instancetype)initWithFrame:(CGRect)frame str:(NSString *)str
{
    if (self =[super initWithFrame:frame])
    {
        self.frame =frame;
        self.textContent=str;
    }
    return self;
}

///绘制文字，rect1指定矩形，绘制文字在这个矩形水平和垂直居中
- (void)toDrawTextWithRect:(CGRect)rect1 str:(NSString*)str1 {
    if( str1 == nil || self.context == nil)
        return;
    
    CGContextSetLineWidth(self.context, 1.0);
    CGContextSetRGBFillColor (self.context, 0.01, 0.01, 0.01, 1);
    
    //段落格式
    NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
    textStyle.alignment = NSTextAlignmentCenter;//水平居中
    //字体
    UIFont  *font = [UIFont boldSystemFontOfSize:10.0];
    //构建属性集合
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:textStyle};
    //获得size
    CGSize strSize = [str1 sizeWithAttributes:attributes];
    CGFloat marginTop = (rect1.size.height - strSize.height)/2;
    //垂直居中要自己计算
    CGRect r = CGRectMake(rect1.origin.x, rect1.origin.y + marginTop,rect1.size.width, strSize.height);
    [str1 drawInRect:r withAttributes:attributes];
}

@end
