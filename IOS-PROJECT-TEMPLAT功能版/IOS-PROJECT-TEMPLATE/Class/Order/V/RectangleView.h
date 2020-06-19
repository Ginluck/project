//
//  RectangleView.h
//  WXQDrawRect
//
//  Created by WXQ on 2018/8/13.
//  Copyright © 2018年 JingBei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RectangleView : UIView
@property(nonatomic,strong)NSString * textContent;
-(instancetype)initWithFrame:(CGRect)frame str:(NSString *)str;
- (void)toDrawTextWithRect:(CGRect)rect1 str:(NSString*)str1;


@end
