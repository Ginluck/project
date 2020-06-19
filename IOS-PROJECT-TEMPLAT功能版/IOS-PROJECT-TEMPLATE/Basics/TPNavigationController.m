//
//  TPNavigationController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2019/7/2.
//  Copyright © 2019年 梦境网络. All rights reserved.
//

#import "TPNavigationController.h"
#import <objc/runtime.h>
@interface TPNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>{
    
    BOOL pushing;
}

@end

@implementation TPNavigationController

+ (void)initialize{
    
    [[UINavigationBar appearance] setShadowImage:KImageNamed(@"")];
    [[UINavigationBar appearance] setTintColor:K_Prokect_MainColor];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    [[UINavigationBar appearance] setBackIndicatorImage:KImageNamed(@"backblack")];
    [UINavigationBar appearance].backIndicatorTransitionMaskImage = KImageNamed(@"backblack");
    
    //    if (@available(iOS 11, *)) {
    ////        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-999, 0) forBarMetrics:UIBarMetricsDefault];
    //    } else {
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    //    }
    
    
    
    //    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithPatternImage:bgImg]];
    [[UINavigationBar appearance] setBarTintColor:K_Prokect_MainColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
    // 用于解决自定义返回按钮后滑动手势失效
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
}

#pragma mark - NavigationController delegate
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    // 用于阻止重复push
    if (pushing){
        
        return;
    }
    pushing = YES;
    
    
    [super pushViewController:viewController animated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    pushing = NO;
    
    [UIViewController attemptRotationToDeviceOrientation];
}

@end
