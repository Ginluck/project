//
//  TPBaseViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2019/7/2.
//  Copyright © 2019年 梦境网络. All rights reserved.
//

#import "TPBaseViewController.h"

@interface TPBaseViewController ()<UINavigationBarDelegate>

@end

@implementation TPBaseViewController



- (void)setIsExtendLayout:(BOOL)isExtendLayout {
    
    if (!isExtendLayout) {
        [self initializeSelfVCSetting];
    } else {
        //        [self initializeSelfVCSetting1];
    }
}

- (void)initializeSelfVCSetting {
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeTop; //导航栏透明
        self.extendedLayoutIncludesOpaqueBars = YES;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)initializeSelfVCSetting1 {
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone; //导航栏透明
        self.extendedLayoutIncludesOpaqueBars = YES;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}


- (void)changeStatusBarStyle:(UIStatusBarStyle)statusBarStyle
             statusBarHidden:(BOOL)statusBarHidden
     changeStatusBarAnimated:(BOOL)animated {
    
    self.statusBarStyle=statusBarStyle;
    self.statusBarHidden=statusBarHidden;
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
        }];
    }
    else{
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (void)hideNavigationBar:(BOOL)isHide
                 animated:(BOOL)animated{
    
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.navigationController.navigationBarHidden=isHide;
        }];
    }
    else{
        self.navigationController.navigationBarHidden=isHide;
    }
}

#pragma mark - 导航栏设置
- (void)setNeedsNavigationBackground:(CGFloat)alpha {
    if (alpha == 0) {
        self.isExtendLayout = NO;
    } else {
        self.isExtendLayout = YES;
    }
    
    // 导航栏背景透明度设置
    UIView *barBackgroundView = [[self.navigationController.navigationBar subviews] objectAtIndex:0];
    UIImageView *backgroundImageView = [[barBackgroundView subviews] objectAtIndex:0];
    
    if (self.navigationController.navigationBar.isTranslucent) {
        if ( backgroundImageView != nil && [backgroundImageView isKindOfClass:[UIImageView class]] && backgroundImageView.image != nil) {
            
            barBackgroundView.alpha = alpha;
            backgroundImageView.alpha = alpha;
            
            if (@available(iOS 11, *)) {
                UIView *backgroundEffectView = [[barBackgroundView subviews] objectAtIndex:1];// UIVisualEffectView
                if (backgroundEffectView != nil) {
                    backgroundEffectView.alpha = alpha;
                    backgroundImageView.alpha = alpha;
                    
                    for (UIView *view in backgroundEffectView.subviews) {
                        view.alpha = alpha;
                    }
                }
            }
        } else {
            
            UIView *backgroundEffectView = [[barBackgroundView subviews] objectAtIndex:1];// UIVisualEffectView
            if (backgroundEffectView != nil) {
                backgroundEffectView.alpha = alpha;
                backgroundImageView.alpha = alpha;
                if (@available(iOS 11, *)) {
                    for (UIView *view in backgroundEffectView.subviews) {
                        view.alpha = alpha;
                    }
                }
            }
        }
    } else {
        barBackgroundView.alpha = alpha;
    }
}

#pragma mark - 屏幕旋转
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate {
    
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return UIInterfaceOrientationPortrait;
}



/**
 *  绑定
 */


- (void)addNavigationItemWithImageName:(NSString *)imgName itemType:(kNavigationItemType)type  action:(SEL)action{
    
    UIImage *img = [KImageNamed(imgName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:img style:UIBarButtonItemStylePlain target:self action:action];
    
    if (type == kNavigationItemTypeLeft) {
        
        self.navigationItem.leftBarButtonItem = item;
    } else{
        
        self.navigationItem.rightBarButtonItem = item;
    }
}

- (void)addNavigationTitleView:(NSString *)title {
    
    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    lbl.text = title;
    lbl.textColor = [UIColor whiteColor];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.font = MKBoldFont(18);
    
    self.navigationItem.titleView = lbl;
}

- (void)addNavigationTitleViewWithImageName:(NSString *)imageName{
    
    UIImageView *imgV = [[UIImageView alloc]initWithImage:KImageNamed(imageName)];
    self.navigationItem.titleView = imgV;
}

- (void)addNavigationItemWithTitle:(NSString *)Title itemType:(kNavigationItemType)type action:(SEL)action{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:Title style:UIBarButtonItemStylePlain target:self action:action];
    
    if (type == kNavigationItemTypeLeft) {
        
        self.navigationItem.leftBarButtonItem = item;
        [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} forState:UIControlStateNormal];
    } else{
        
        self.navigationItem.rightBarButtonItem = item;
        [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    }
}



//- (void)configKeyboard{
//
//    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
//
//    keyboardManager.enable = YES; // 控制整个功能是否启用
//
//    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
//
//    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
//
//    keyboardManager.toolbarManageBehaviour = IQAutoToolbarByPosition; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
//
//    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
//
//    keyboardManager.shouldShowToolbarPlaceholder = YES; // 是否显示占位文字
//
//    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:14]; // 设置占位文字的字体
//
//    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (@available(iOS 11, *)) {
        if (!self.hideNavigationBar && self.navigationController){
            
            // 不是rootViewController
            NSArray *arrray = self.navigationController.viewControllers;
            if (![self isEqual:[arrray firstObject]]){
                
                [self addNavigationItemWithImageName:@"back_white" itemType:kNavigationItemTypeLeft action:@selector(back)];
            }
        }
    }
    
    WS(weakSelf);
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = weakSelf;
    }
    self.view.backgroundColor =kBGViewCOLOR;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
