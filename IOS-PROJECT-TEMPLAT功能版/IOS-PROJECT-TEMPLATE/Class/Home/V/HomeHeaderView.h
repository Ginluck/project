//
//  HomeHeaderView.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/7.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeaderViewDelegate <NSObject>

-(void)headerViewClick:(UIButton *)button;

@end
NS_ASSUME_NONNULL_BEGIN
typedef void(^ViewClickBlock)(NSInteger index);
@interface HomeHeaderView : UIView
@property(nonatomic,assign)id<HeaderViewDelegate>delegate;
@property (nonatomic, strong) NSArray *arrBanners;
@property(nonatomic,strong)ViewClickBlock VCClick;
@property(nonatomic,weak)IBOutlet UILabel * allLab;
@property(nonatomic,weak)IBOutlet UILabel * zsLab;
@property(nonatomic,weak)IBOutlet UILabel * lsLab;
@property (weak, nonatomic) IBOutlet UIButton *ChageBtn;

@end

NS_ASSUME_NONNULL_END
