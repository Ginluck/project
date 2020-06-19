//
//  GongFengRecordViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/9.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "GongFengRecordViewController.h"
#import "GongFengOnewViewController.h"
#import "GongFengTwoViewController.h"
#import "GongFengThreeViewController.h"
@interface GongFengRecordViewController ()

@end

@implementation GongFengRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitleView:@"供奉记录"];
        // Do any additional setup after loading the view from its nib.
        self.tabedSlideView.baseViewController = self;
        //未选中字体颜色
        self.tabedSlideView.tabItemNormalColor = [UIColor lightGrayColor];
        //选中字体颜色
        self.tabedSlideView.tabItemSelectedColor = [UIColor blackColor];
        //下面线颜色
        self.tabedSlideView.tabbarTrackColor = [UIColor redColor];
        self.tabedSlideView.tabbarBackgroundImage = [UIImage imageNamed:@"baikuang"];
        //距离下面多少
        self.tabedSlideView.tabbarBottomSpacing = 15;
        
        self.tabedSlideView.tabbarHeight=44;
        
        DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"公告祠堂" image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];
        DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"私人祠堂" image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];
           DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"我的供奉" image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];


        self.tabedSlideView.tabbarItems = @[item1, item2,item3];
        [self.tabedSlideView buildTabbar];
        self.tabedSlideView.selectedIndex=0;
        
//         [self addNavigationItemWithImageName:@"backblack" itemType:kNavigationItemTypeLeft action:@selector(backAction)];
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:ImageNamed(@"backblack") style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    }
 
    - (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
        return 3;
    }
    - (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index{
        switch (index) {
            case 0:
            {
                GongFengOnewViewController *ctrl = [[GongFengOnewViewController alloc] init];
                return ctrl;
            }
            case 1:
            {
                
                GongFengTwoViewController *ctrl = [[GongFengTwoViewController alloc] init];
              
                return ctrl;
            }
                
            case 2:
            {
                
                GongFengThreeViewController *ctrl = [[GongFengThreeViewController alloc] init];
                
                return ctrl;
            }
            default:
                return nil;
        }
    }
    -(void)awakeFromNib
    {
        [super awakeFromNib];
        DLog(@"1");
    }
    - (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }


    @end
