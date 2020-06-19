//
//  MBProgressHUD+NJ.m
//  NJWisdomCard
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 Weconex. All rights reserved.
//

#import "MBProgressHUD+NJ.h"
#import "UIImage+GIF.h"
@implementation MBProgressHUD (NJ)

/**
 *  显示信息
 *
 *  @param text 信息内容
 *  @param icon 图标
 *  @param view 显示的视图
 */
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    if (text.length > 10)
    {
        hud.detailsLabel.text = text;

    }
    else
    {
        hud.label.text = text;

    }
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    hud.bezelView.color = COLOR(25, 26, 27,1);
    hud.contentColor = [UIColor whiteColor];
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1];
}

/**
 *  显示成功信息
 *
 *  @param success 信息内容
 */
+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

/**
 *  显示成功信息
 *
 *  @param success 信息内容
 *  @param view    显示信息的视图
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

/**
 *  显示错误信息
 *
 */
+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

/**
 *  显示错误信息
 *
 *  @param error 错误信息内容
 *  @param view  需要显示信息的视图
 */
+ (void)showError:(NSString *)error toView:(UIView *)view{
    
    [self show:error icon:@"error.png" view:view];
}

/**
 *  显示错误信息
 *
 *  @param message 信息内容
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

/**
 *  显示一些信息
 *
 *  @param message 信息内容
 *  @param view    需要显示信息的视图
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = @"加载中…";
    hud.mode = MBProgressHUDModeCustomView;
//    UIImageView *gifImageV = [[UIImageView alloc] initWithImage:[UIImage sd_animatedGIFNamed:@"Loading"]];
//    hud.customView = gifImageV;
    
    hud.bezelView.color = COLOR(25, 26, 27,1);

    //文字颜色
    hud.contentColor = [UIColor whiteColor];
    hud.animationType = MBProgressHUDAnimationFade;
    
//
//    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
//    // 快速显示一个提示信息
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//
////    之前的
//    /*
//    hud.labelText = message;
//    // 隐藏时候从父控件中移除
//    hud.removeFromSuperViewOnHide = YES;
//    // YES代表需要蒙版效果
//    hud.dimBackground = NO;
//    */
//    hud.mode = MBProgressHUDModeCustomView;
//
//    UIImageView *gifImageV = [[UIImageView alloc] initWithImage:[UIImage sd_animatedGIFNamed:@"Loading"]];
//    gifImageV.center = view.center;
//    gifImageV.bounds = CGRectMake(0, 0, 100, 95);
//    gifImageV.clipsToBounds = YES;
//    gifImageV.layer.cornerRadius = 5;
//    hud.customView = gifImageV;
//
//    UILabel *textLabel = [[UILabel alloc] init];
//    //    textLabel.center = CGPointMake(view.center.x, view.center.y + 15);
//    //    textLabel.bounds = CGRectMake(0, 0, SCREEN_WIDTH, 15);
//    textLabel.frame = CGRectMake(0, hud.center.y - 22.5, hud.frame.size.width, 15);
//    textLabel.textAlignment = NSTextAlignmentCenter;
//    textLabel.font = [UIFont systemFontOfSize:15];
//    if (message.length > 0)
//    {
//        textLabel.text = message;
//    }
//    else
//    {
//        textLabel.text = @"加载中...";
//
//    }
//    textLabel.textColor = [UIColor whiteColor];
//    [hud addSubview:textLabel];
//
//    hud.color = [UIColor clearColor];
//    hud.alpha = 0.7;
    return hud;
}

/**
 *  手动关闭MBProgressHUD
 */
+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

/**
 *  手动关闭MBProgressHUD
 *
 *  @param view    显示MBProgressHUD的视图
 */
+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
}

@end
