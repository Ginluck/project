//
//  OpinionFeedBackView.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/6/18.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol OpinionViewDelegate <NSObject>

-(void)opinionViewClick:(UIButton *)button;

@end
@interface OpinionFeedBackView : UIView
@property(nonatomic,assign)id<OpinionViewDelegate>delegate;
@property(nonatomic,weak)IBOutlet UITextView * feedView;
@end

NS_ASSUME_NONNULL_END
