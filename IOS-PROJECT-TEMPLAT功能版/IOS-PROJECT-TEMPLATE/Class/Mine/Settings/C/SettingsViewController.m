//
//  SettingsViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/8.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsTableViewCell.h"
#import "TeasingViewController.h"
#import "AboutMeViewController.h"
#import "IDSafeViewController.h"
#import "SZKCleanCache.h"
@interface SettingsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * TitleAry;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self addNavigationTitleView:@"设置"];
    [self.view addSubview:self.tableView];
       [self.view sendSubviewToBack:self.tableView];
       self.tableView.backgroundColor=COLOR(244, 245, 246, .8);
       self.TitleAry =[NSArray arrayWithObjects:@[@"账户安全"],@[@"意见反馈",@"关于祭祖平台"],@[@"清理缓存"], nil];
    // Do any additional setup after loading the view from its nib.
}
- (UITableView *)tableView
{
    if (!_tableView)
    {
         _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, K_NaviHeight, Screen_Width, Screen_Height-kNavagationBarH ) style:UITableViewStyleGrouped];
                     _tableView.delegate = self;
                     _tableView.dataSource = self;
                     UIImageView * imageV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, CGRectGetHeight(_tableView.frame))];
                     imageV.image =KImageNamed(@"通用背景");
                     _tableView.backgroundView =imageV;
                  
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = [UIColor clearColor];
        if (@available(iOS 11, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SettingsTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SettingsTableViewCell class])];
        
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.TitleAry.count;
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 8)];
    view.backgroundColor=COLOR(244, 245, 246, .8);
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = self.TitleAry[section];
    return  arr.count;
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
     if (section==2) {
         return 48;
     }
    return 0.00001;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==2) {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 48)];
        view.backgroundColor=COLOR(244, 245, 246, .8);
        UIButton *Btn =[[UIButton alloc]initWithFrame:CGRectMake(0, 8, Screen_Width, 40)];
        [Btn setTitle:@"退出登录" forState:UIControlStateNormal];
        Btn.backgroundColor=[UIColor whiteColor];
        [Btn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [Btn addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:Btn];
        return view;
    }
    return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SettingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SettingsTableViewCell class]) forIndexPath:indexPath];
    cell.Lab.text=self.TitleAry[indexPath.section][indexPath.row];
    if (indexPath.section==1&&indexPath.row==0) {
        cell.line.alpha=1;
    }else
    {
        cell.line.alpha=0;
    }
    cell.selectionStyle  =UITableViewCellSeparatorStyleNone;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        IDSafeViewController*TVC=[IDSafeViewController new];
        [self.navigationController pushViewController:TVC animated:YES];
    }else if (indexPath.section==1)
    {
        if (indexPath.row==0) {
            TeasingViewController *TVC=[TeasingViewController new];
            [self.navigationController pushViewController:TVC animated:YES];
        }else
        {
            AboutMeViewController*TVC=[AboutMeViewController new];
            [self.navigationController pushViewController:TVC animated:YES];
        }
    }else
    {
        [SZKCleanCache cleanCache:^{
            ShowMessage(@"清理成功");
            [self.tableView reloadData];
        }];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
