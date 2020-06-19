//
//  TPBaseTabbarViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2019/7/2.
//  Copyright © 2019年 梦境网络. All rights reserved.
//

#import "TPBaseTabbarViewController.h"
#import "TPNavigationController.h"
#import "HomeViewController.h"
#import "OrderHomeController.h"
#import "MessageHomeController.h"
#import "PersonCenterController.h"
#import "TypeHomeController.h"
@interface TPBaseTabbarViewController ()<UITabBarControllerDelegate>
@property(nonatomic,strong)NSArray *VCArr;
@end

@implementation TPBaseTabbarViewController
//-(void)dealloc
//{
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.delegate=self;
    self.tabBar.backgroundColor=K_Prokect_MainColor;
    self.tabBar.barTintColor=K_Prokect_MainColor;
    self.delegate=self;
    [self configTabbar];
//    [self addNoti];
}

//-(void)addNoti
//{
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginOutTarget:) name:kMKLoginOutNotifcationKey object:nil];
//}

-(void)configTabbar
{
    NSArray *titleArr = @[@"祠堂",@"族谱",@"寻祖",@"消息",@"我的"];
    NSArray *normalIconArr = @[@"祠堂图标",@"族谱图标",@"寻祖图标",@"消息图标",@"我的图标"];
    NSArray *selectedIconArr = @[@"祠堂图标选中",@"族谱图标选中",@"寻祖图标选中",@"消息图标选中",@"我的图标选中"];
   self.VCArr = @[[HomeViewController new],[TypeHomeController new],[OrderHomeController new],[MessageHomeController new],[PersonCenterController new]];
    NSMutableArray *navs = [NSMutableArray arrayWithCapacity:5];
    for (int i=0; i<titleArr.count; i++) {
        NSString *barTitle = titleArr[i];
        UIImage *barNormalImage = [UIImage imageNamed:normalIconArr[i]];
        UIImage *selectedNormalImage = [UIImage imageNamed:selectedIconArr[i]];
        UITabBarItem * tabBarItem = [[UITabBarItem alloc]initWithTitle:barTitle image:[self tabBarItemImage:barNormalImage] selectedImage:[self tabBarItemImage:selectedNormalImage]];
        [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:k_Project_TabbarTextColor} forState:UIControlStateNormal];
        [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
        UIViewController *subViewController = self.VCArr[i];
        subViewController.tabBarItem = tabBarItem;
        TPNavigationController *navController = [[TPNavigationController alloc]initWithRootViewController:subViewController];
        [navs addObject:navController];
    }
    self.viewControllers = navs;
}

-(UIImage*)tabBarItemImage:(UIImage *)image
{
    UIImage * tabBarImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return tabBarImage;
}

-(void)loginOutTarget:(NSNotification *)noti
{
    TPNavigationController *nav = self.viewControllers[self.selectedIndex];
    [nav popToRootViewControllerAnimated:YES];
}

//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
//{
//    TPNavigationController * nav =(TPNavigationController*)viewController;
//    if ([nav.viewControllers[0] isKindOfClass:[HomeViewController class]]||[nav.viewControllers[0] isKindOfClass: [TypeHomeController class]]) {
//        UserModel * model =[[UserManager shareInstance]getUser];
//        if (!model.jzId.length)
//        {
//            ShowMessage(@"您暂时没有加入家族,请先寻找家族");
//            return NO;
//        }
//        return YES;;
//    }
//    return YES;
//}
@end
