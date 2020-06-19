//
//  ShareView.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/6/11.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol shareViewDelegate <NSObject>

-(void)shareViewBtnClick:(UIButton *)button;

@end
@interface ShareView : UIView
@property(nonatomic,assign)id<shareViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
