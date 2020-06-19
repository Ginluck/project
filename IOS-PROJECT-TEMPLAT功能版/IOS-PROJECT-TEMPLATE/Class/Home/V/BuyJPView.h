//
//  BuyJPView.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/25.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JipinModel.h"
#import "JipinChild.h"
NS_ASSUME_NONNULL_BEGIN
@protocol BuyViewDelegate <NSObject>

-(void)buyViewDelegate:(UIButton *)sender time:(NSString *)time  amount:(NSString *)money pro:(NSString *)proId count:(NSString * )count model:(JipinChild*)model;

@end
@interface BuyJPView : UIView
@property(nonatomic,assign)id<BuyViewDelegate>delegate;
-(void)refreshUI:(JipinChild * )model;
@end

NS_ASSUME_NONNULL_END
