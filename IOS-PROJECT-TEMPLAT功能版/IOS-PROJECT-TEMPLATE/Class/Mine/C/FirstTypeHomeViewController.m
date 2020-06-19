//
//  FirstTypeHomeViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/6/12.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "FirstTypeHomeViewController.h"
#import "FamilyDetailController.h"
#import "CitangCell.h"
#import "FirstTypeHomeTableViewCell.h"
#import "FamilyListModel.h"
#import "CitangHeaderView.h"
@interface FirstTypeHomeViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray  * dataAry ;
@property(nonatomic,assign)NSInteger  page;
@property(nonatomic,strong)CitangHeaderView * headerView;

@end

@implementation FirstTypeHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitleView:@"族谱"];
    [self.view addSubview:self.tableView];
    [self regisNib];
    self.tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self postDate];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page = self.page + 1;
        [self refreshPostData];

    }];
    

//     Do any additional setup after loading the view from its nib.
}

-(CitangHeaderView *)headerView
{
    if (!_headerView) {
        _headerView =[[[NSBundle mainBundle] loadNibNamed:@"CitangHeaderView" owner:self options:nil] firstObject];
        _headerView.frame =CGRectMake(0, 0, Screen_Width,Screen_Width*256/1034+40);
    }
    return _headerView;
}

-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, K_NaviHeight, Screen_Width, Screen_Height-K_NaviHeight-40) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView =self.headerView;
        UIImageView * imageV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, CGRectGetHeight(_tableView.frame))];
        imageV.image =KImageNamed(@"家谱背景");
        _tableView.backgroundView =imageV;
        _tableView.emptyDataSetSource =self;
        _tableView.emptyDataSetDelegate=self;
        _tableView.backgroundColor =[UIColor clearColor];
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

-(void)regisNib
{
  [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FirstTypeHomeTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([FirstTypeHomeTableViewCell class])];
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
    return 111;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FirstTypeHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FirstTypeHomeTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle  =UITableViewCellSeparatorStyleNone;
    cell.backgroundView .backgroundColor =[UIColor clearColor];
    cell.backgroundColor =[UIColor clearColor];
    [cell reloadCell:self.dataAry[indexPath.row]];
    cell.detailButton.tag =indexPath.row;
    [cell.detailButton addTarget:self action:@selector(detailClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void)detailClick:(UIButton *)sender
{
    FamilyListModel * model =self.dataAry[sender.tag];
    UserModel * Usermodel =[[UserManager shareInstance]getUser];
//    FamilyDetailController * fvc =[FamilyDetailController new];
//    fvc.hidesBottomBarWhenPushed =YES;
//    fvc.model =model;
//    [self.navigationController pushViewController:fvc animated:YES];
    NSDictionary * param =@{@"zpId":model.id,@"userId":Usermodel.id};
       [RequestHelp POST:update_appZp_URL parameters:param success:^(id result) {
           DLog(@"%@",result);
           ShowMessage(@"加入成功");
           if(self.VCClick)
                      {
                          self.VCClick(0);
                      }
        [self.navigationController popViewControllerAnimated:YES];
         
       } failure:^(NSError *error) {
           [self endRefresh];
       }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    FamilyListModel * model =self.dataAry[indexPath.row];
//    FamilyDetailController * fvc =[FamilyDetailController new];
//    fvc.hidesBottomBarWhenPushed =YES;
//    fvc.model =model;
//    [self.navigationController pushViewController:fvc animated:YES];
    
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
    [self refreshPostData];
}
-(void)refreshPostData
{
    UserModel * model =[[UserManager shareInstance]getUser];
    NSDictionary * param =@{@"name":model.userName,@"address":model.address};
    [RequestHelp POST:select_LIST_URL parameters:param success:^(id result) {
        DLog(@"%@",result);
        [self.dataAry addObjectsFromArray:[NSArray yy_modelArrayWithClass:[FamilyListModel class] json:result[@"list"]]];
        if(self.dataAry.count==0)
        {
            if(self.VCClick)
            {
                self.VCClick(0);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            [self.tableView reloadData];
                   [self endRefresh];
        }
    } failure:^(NSError *error) {
        [self endRefresh];
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [self postDate];
}
@end
