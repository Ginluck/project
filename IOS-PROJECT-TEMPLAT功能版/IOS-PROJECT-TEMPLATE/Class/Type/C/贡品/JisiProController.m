//
//  JisiProController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/12.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "JisiProController.h"
#import "XingliProController.h"
#import "GongpinController.h"
#import "TaoCanViewController.h"
#import "JipinModel.h"
@interface JisiProController ()

@end

@implementation JisiProController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitleView:@"祭品"];
    // Do any additional setup after loading the view from its nib.
    self.tabedSlideView.baseViewController = self;
    //未选中字体颜色
    self.tabedSlideView.tabItemNormalColor = [UIColor whiteColor];
    //选中字体颜色
    self.tabedSlideView.tabItemSelectedColor = [UIColor blackColor];
    //下面线颜色
    self.tabedSlideView.tabbarTrackColor = K_Prokect_MainColor;
    self.tabedSlideView.tabbarBackgroundImage =[self createImageWithColor:K_Prokect_MainColor];
    //距离下面多少
    self.tabedSlideView.tabbarBottomSpacing = 0;
    
    self.tabedSlideView.tabbarHeight=44;
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"行礼" image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"供品" image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];
    DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"套餐" image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];
    
    
    self.tabedSlideView.tabbarItems = @[item1, item2,item3];
    [self.tabedSlideView buildTabbar];
    self.tabedSlideView.selectedIndex=0;
    
    //         [self addNavigationItemWithImageName:@"backblack" itemType:kNavigationItemTypeLeft action:@selector(backAction)];
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:ImageNamed(@"backblack") style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
}
- (UIImage *)createImageWithColor: (UIColor *)color;
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
    return 3;
}
- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index{
    switch (index) {
        case 0:
        {
            XingliProController *ctrl = [[XingliProController alloc] init];
            ctrl.block = ^(JipinChild * _Nonnull model) {
                self.block(model);
            };
            ctrl.model =self.model;
            return ctrl;
        }
        case 1:
        {
            
            GongpinController *ctrl = [[GongpinController alloc] init];
            ctrl.block = ^(JipinChild * _Nonnull model) {
                self.block(model);
            };
            ctrl.model =self.model;
            return ctrl;
        }
            
        case 2:
        {
            
            TaoCanViewController *ctrl = [[TaoCanViewController alloc] init];
            
            return ctrl;
        }
        default:
            return nil;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
