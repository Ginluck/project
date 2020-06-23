//
//  QiandaoView.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/6/23.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignModel.h"
#import "HongBaoView.h"
NS_ASSUME_NONNULL_BEGIN
@protocol QiandaoViewDelegate <NSObject>

-(void)qiandaoClick;
-(void)hongbaoClick:(UIButton *)model;
-(void)qiandaoClose;

@end
@interface QiandaoView : UIView
@property(nonatomic,strong)SignModel * model;
@property(nonatomic,assign)id<QiandaoViewDelegate>  delegate;
@end

NS_ASSUME_NONNULL_END
