//
//  JipinView.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/12.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JPButton;
NS_ASSUME_NONNULL_BEGIN

@interface JipinView : UIView
@property(nonatomic,strong) UILabel * topLab;
@property(nonatomic,strong) UILabel * bottomLab;
@property(nonatomic,strong) UIImageView * proImage;
@property(nonatomic,strong) JPButton * clickBtn;
@end
@interface JPButton : UIButton
@property(nonatomic,assign)NSInteger row;
@end


NS_ASSUME_NONNULL_END
