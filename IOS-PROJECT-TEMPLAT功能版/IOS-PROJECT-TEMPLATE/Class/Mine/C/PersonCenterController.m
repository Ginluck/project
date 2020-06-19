
//
//  PersonCenterController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2019/12/10.
//  Copyright © 2019年 梦境网络. All rights reserved.
//

#import "PersonCenterController.h"
#import "GongFengRecordViewController.h"
#import "SetHeadViewController.h"
#import "RZMessageViewController.h"
#import "TeasingViewController.h"
#import "AboutMeViewController.h"
#import "IDSafeViewController.h"
#import "SZKCleanCache.h"
#import "MineHeaderView.h"
#import "ContactCustomerViewController.h"
#import "MoneyRecordViewController.h"
#import "RecordMoneyViewController.h"
@interface PersonCenterController ()
@property(nonatomic,strong)MineHeaderView * MHView;

@end

@implementation PersonCenterController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self requestData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView * imageV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
              imageV.image =KImageNamed(@"通用背景");
    [self.view addSubview:imageV];
    [self.view addSubview:self.MHView];
    [self addNavigationTitleView:@"我的"];
   
    // Do any additional setup after loading the view.
}
-(void)requestData
{
    UserModel * model =[[UserManager shareInstance]getUser];
       NSDictionary* param_dic =@{@"userPhone":model.userPhone};
       [RequestHelp POST:SELECT_USERINFO_url parameters:param_dic success:^(id result) {
           MKLog(@"%@",result);
         MineDataModel *model =[MineDataModel yy_modelWithJSON:result];
           [self.MHView setModel:model];
       } failure:^(NSError *error) {
           
       }];
    [RequestHelp POST:appSelectYuEById_URL parameters:@{} success:^(id result) {
           MKLog(@"%@",result);
        [self.MHView.GoldBtn setTitle:[NSString stringWithFormat:@"纪念币：%@",result] forState:UIControlStateNormal];
       } failure:^(NSError *error) {
           
       }];
}
-(MineHeaderView *)MHView
{
    WS(weakSelf);
    if (!_MHView) {
        _MHView=[[NSBundle mainBundle]loadNibNamed:@"MineHeaderView" owner:nil options:nil][0];
        _MHView.frame =CGRectMake(0, kNavagationBarH, Screen_Width, 550);
        [_MHView.HeaderBtn addTarget:self action:@selector(HeaderClick) forControlEvents:UIControlEventTouchUpInside];
           [_MHView.LoginOutBtn addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
         [_MHView.GoldBtn addTarget:self action:@selector(GoldClick) forControlEvents:UIControlEventTouchUpInside];
          _MHView.VCClick = ^(NSInteger index) {
              [weakSelf BtnViewClick:index];
          };
    }
    return _MHView;
}

-(void)HeaderClick
{
    SetHeadViewController *GFRVC=[SetHeadViewController new];
    GFRVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:GFRVC animated:YES];
}
-(void)BtnViewClick:(NSInteger )index
{
    UserModel * model =[[UserManager shareInstance]getUser];
    switch (index) {
        case 0:
        {
             //认祖申请
           RZMessageViewController *GFRVC=[RZMessageViewController new];
           GFRVC.TypeStr=@"2";
           GFRVC.hidesBottomBarWhenPushed=YES;
           [self.navigationController pushViewController:GFRVC animated:YES];
        }
            break;
            case 1:
            {
              //供奉记录
                               if (model.jzId==nil) {
                                   ShowMessage(@"您还没有家族");
                               }else
                               {
                                   GongFengRecordViewController *GFRVC=[GongFengRecordViewController new];
                                                  GFRVC.hidesBottomBarWhenPushed=YES;
                                                  [self.navigationController pushViewController:GFRVC animated:YES];
                               }
               
            }
                break;
            case 2:
            {
               //认祖审核
//                if ([model.patriarch isEqualToString:@"1"]) {
                    RZMessageViewController *GFRVC=[RZMessageViewController new];
                    GFRVC.TypeStr=@"1";
                    GFRVC.hidesBottomBarWhenPushed=YES;
                    [self.navigationController pushViewController:GFRVC animated:YES];
//                }else
//                {
//                    ShowMessage(@"没有权限");
//                }
                
            }
                break;
            case 3:
            {
                //账户安全
                IDSafeViewController*TVC=[IDSafeViewController new];
                TVC.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:TVC animated:YES];
            }
                break;
            case 4:
            {
                //金币充值
               
            }
                break;
            case 5:
            {
               //关于
                AboutMeViewController*TVC=[AboutMeViewController new];
                TVC.hidesBottomBarWhenPushed=YES;
                           [self.navigationController pushViewController:TVC animated:YES];
            }
                break;
            case 6:
            {
                 //清理缓存
                [SZKCleanCache cleanCache:^{
                           ShowMessage(@"清理成功");
                           
                       }];
            }
                break;
        case 7:
                   {
                      //联系客服
                      
                       ContactCustomerViewController *GFRVC=[ContactCustomerViewController new];
                                  GFRVC.hidesBottomBarWhenPushed=YES;
                                  [self.navigationController pushViewController:GFRVC animated:YES];
                   }
                       break;
            case 8:
                              {
                                 //意见反馈
                                 TeasingViewController *TVC=[TeasingViewController new];
                                                TVC.hidesBottomBarWhenPushed=YES;
                                                [self.navigationController pushViewController:TVC animated:YES];
                              }
                                  break;
            
        default:
            break;
    }
}
-( float )readCacheSize
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES) firstObject];
    return [ self folderSizeAtPath :cachePath];
}
- ( float ) folderSizeAtPath:( NSString *) folderPath{
    
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject]) != nil ){
        //获取文件全路径
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    
    return folderSize/( 1024.0 * 1024.0);
    
}
// 计算 单个文件的大小
- ( long long ) fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil] fileSize];
    }
    return 0;
}
-(void)logOut
{
    UserModel * model =[[UserManager shareInstance]getUser];
    [RequestHelp POST:exit_url parameters:@{@"userPhone":model.userPhone} success:^(id result){
       DLog(@"%@",result);
        [[UserManager shareInstance]removeUserId];
        [[UserManager shareInstance]removeToken];
        [[UserManager shareInstance]removeUser];
        [ViewControllerManager showLoginViewController];
    } failure:^(NSError *error) {

   }];
}
-(void)GoldClick
{
    RecordMoneyViewController * mvc =[RecordMoneyViewController new];
    mvc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:mvc animated:YES];
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
