//
//  UILabel+WY_Extension.m
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/11/27.
//  Copyright © 2018 jacke-xu. All rights reserved.
//

#import "UILabel+WY_Extension.h"

@implementation UILabel (WY_Extension)

- (CGFloat)wy_lineHeight {return self.font.lineHeight;}

- (void)wy_leftAlignment {self.textAlignment = NSTextAlignmentLeft;}

- (void)wy_centerAlignment {self.textAlignment = NSTextAlignmentCenter;}

- (void)wy_rightAlignment {self.textAlignment = NSTextAlignmentRight;}

+ (UILabel *)wy_createLabWithFrame:(CGRect)frame textColor:(UIColor *)textColor font:(UIFont *)font {
    
    UILabel *lab = [[UILabel alloc]initWithFrame:frame];
    lab.textColor = textColor;
    lab.font = font;
    
    return lab;
}


- (NSString *)verticalText{
    // 利用runtime添加属性
    return objc_getAssociatedObject(self, @selector(verticalText));
}

- (void)setVerticalText:(NSString *)verticalText {
    objc_setAssociatedObject(self, &verticalText, verticalText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSMutableString *str = [[NSMutableString alloc] initWithString:verticalText];
    NSInteger count = str.length;
    for (int i = 1; i < count; i ++) {
        [str insertString:@"\n" atIndex:i*2-1];
    }
    if (str.length>4) {
        self.text = [str substringToIndex:5];
    }
    else
    {
        self.text =str;
    }
    
    self.numberOfLines = 0;
}

- (void) textLeftTopAlign
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12.f], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [self.text boundingRectWithSize:CGSizeMake(320, Screen_Height-kNavagationBarH-320) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    CGRect dateFrame =CGRectMake(2, 140, CGRectGetWidth(self.frame)-5, labelSize.height);
    self.frame = dateFrame;
}
@end
