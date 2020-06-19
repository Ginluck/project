//
//  TPBaseViewController.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2019/7/2.
//  Copyright © 2019年 梦境网络. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, kNavigationItemType) {
    kNavigationItemTypeLeft,
    kNavigationItemTypeRight,
};

NS_ASSUME_NONNULL_BEGIN

@interface TPBaseViewController : UIViewController

///状态栏的风格
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;
///状态栏隐藏状态
@property (nonatomic, assign) BOOL statusBarHidden;
///修改状态栏的动画
@property (nonatomic, assign) BOOL changeStatusBarAnimated;

@property (nonatomic, getter=isHideNavigationBar) IBInspectable BOOL hideNavigationBar;

@property (nonatomic, getter=isHideStatusBar) BOOL hideStatusBar;

/**
 *  VIEW是否渗透导航栏
 * (YES_VIEW渗透导航栏下／NO_VIEW不渗透导航栏下)
 */
@property (assign,nonatomic) BOOL isExtendLayout;

/**
 * 功能：设置修改StatusBar
 * 参数：（1）StatusBar样式：statusBarStyle
 *      （2）是否隐藏StatusBar：statusBarHidden
 *      （3）是否动画过渡：animated
 */

-(void)changeStatusBarStyle:(UIStatusBarStyle)statusBarStyle
            statusBarHidden:(BOOL)statusBarHidden
    changeStatusBarAnimated:(BOOL)animated;


/**
 * 功能：隐藏显示导航栏
 * 参数：（1）是否隐藏导航栏：isHide
 *      （2）是否有动画过渡：animated
 */
-(void)hideNavigationBar:(BOOL)isHide
                animated:(BOOL)animated;

/**
 设置导航栏的透明度
 
 @param alpha 0~1
 */
- (void)setNeedsNavigationBackground:(CGFloat)alpha;

/**
 添加导航栏按钮
 
 @param imgName 图片名字
 @param type 左右按钮类型
 @param action 响应方法
 */
- (void)addNavigationItemWithImageName:(NSString *)imgName itemType:(kNavigationItemType)type  action:(SEL)action;

/**
 添加导航栏按钮
 
 @param Title 标题
 @param type 左右按钮类型
 @param action 响应方法
 */
- (void)addNavigationItemWithTitle:(NSString *)Title itemType:(kNavigationItemType)type  action:(SEL)action;

/**
 添加导航栏视图标题
 
 @param title 标题
 @param color 颜色
 */
- (void)addNavigationTitleView:(NSString *)title;

/**
 添加导航栏视图标题
 
 @param imageName 图片名字
 
 */
- (void)addNavigationTitleViewWithImageName:(NSString *)imageName;

- (void)back;
@end

NS_ASSUME_NONNULL_END
