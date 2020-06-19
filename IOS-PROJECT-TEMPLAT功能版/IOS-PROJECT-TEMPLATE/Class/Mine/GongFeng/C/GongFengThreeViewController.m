//
//  GongFengThreeViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/9.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "GongFengThreeViewController.h"
#import "GongFengOneTableViewCell.h"
#import "GongPinDetialViewController.h"
#import "GongFengListModel.h"
#import "WorshipController.h"
@interface GongFengThreeViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray  * dataAry ;
@property(nonatomic,assign)NSInteger  page;

@end

@implementation GongFengThreeViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
       [self regisNib];
    [self postDate];
       self.tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
           [self postDate];
       }];
       self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
           self.page = self.page + 1;
           [self refreshPostData];
           
       }];
    // Do any additional setup after loading the view from its nib.
}
-(UITableView *)tableView
{
    if (!_tableView)
    {
         _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height -K_NaviHeight-44) style:UITableViewStyleGrouped];
                            _tableView.delegate = self;
                            _tableView.dataSource = self;
                            UIImageView * imageV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, CGRectGetHeight(_tableView.frame))];
                            imageV.image =KImageNamed(@"通用背景");
                            _tableView.backgroundView =imageV;
        _tableView.emptyDataSetSource =self;
        _tableView.emptyDataSetDelegate=self;
        _tableView.backgroundColor =kBGViewCOLOR;
        _tableView.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

-(void)regisNib
{
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GongFengOneTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([GongFengOneTableViewCell class])];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataAry.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GongFengOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GongFengOneTableViewCell class]) forIndexPath:indexPath];
    GongFengListModel *model=self.dataAry[indexPath.row];
    [cell setModel:model];
    cell.selectionStyle  =UITableViewCellSeparatorStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorshipController *GPDVC=[WorshipController new];
    CitangListModel* modal =[CitangListModel new];
    GongFengListModel *model=self.dataAry[indexPath.row];
    modal.id=model.ctId;
    GPDVC.model=modal;
    [self.navigationController pushViewController:GPDVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
-(void)endRefresh
{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
#pragma mark -- 设置暂无数据背景
- (void)setupNotData
{
    //加载背景
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"无数据"];
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}
-(NSMutableArray *)dataAry
{
    if (!_dataAry) {
        _dataAry =[NSMutableArray new];
    }
    return _dataAry;
}
-(void)postDate
{
    self.page = 1;
    [self.dataAry removeAllObjects];
    [self.tableView reloadData];
    [self refreshPostData];
}
-(void)refreshPostData
{
//    UserModel * model =[[UserManager shareInstance]getUser];
    NSDictionary * param =@{@"pageNum":@(self.page),@"pageRow":@"10",@"status":@"2",@"jzId":@"",@"ctId":@""};
        [RequestHelp POST:selectAppRechargeRecord parameters:param success:^(id result) {
            DLog(@"%@",result);
            [self.dataAry addObjectsFromArray:[NSArray yy_modelArrayWithClass:[GongFengListModel class] json:result[@"list"]]];
            [self setupNotData];
            [self.tableView reloadData];
            [self endRefresh];
        } failure:^(NSError *error) {
            [self endRefresh];
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
