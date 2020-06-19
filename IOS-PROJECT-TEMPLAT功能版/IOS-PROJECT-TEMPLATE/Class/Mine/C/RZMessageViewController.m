//
//  RZMessageViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/22.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "RZMessageViewController.h"
#import "RZMessageTableViewCell.h"
#import "RZMessageModel.h"
#import "RZLookReasonViewController.h"
#import "JZMessageViewController.h"
@interface RZMessageViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray  * dataAry ;
@property(nonatomic,assign)NSInteger  page;

@end

@implementation RZMessageViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
     [self postDate];
}
- (void)viewDidLoad {
    [super viewDidLoad];
       if ([self.TypeStr isEqualToString:@"1"]) {
            [self addNavigationTitleView:@"认祖审核"];
       }else
       {
           [self addNavigationTitleView:@"认祖申请"];
       }
   
    // Do any additional setup after loading the view from its nib.

      [self.view addSubview:self.tableView];
       [self regisNib];
  
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
         _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, K_NaviHeight, Screen_Width, Screen_Height-kNavagationBarH ) style:UITableViewStyleGrouped];
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
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RZMessageTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([RZMessageTableViewCell class])];
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
    return 110;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RZMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RZMessageTableViewCell class]) forIndexPath:indexPath];
    RZMessageModel *model=self.dataAry[indexPath.row];
    [cell setModel:model type:self.TypeStr];
    cell.lookBtn.tag=100+indexPath.row;
    cell.lookBtn.tag=10000+indexPath.row;
    [cell.lookBtn addTarget:self action:@selector(GoLook:) forControlEvents:UIControlEventTouchUpInside];
    [cell.cencelBtn addTarget:self action:@selector(Gocencel:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle  =UITableViewCellSeparatorStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
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
    [self.tableView reloadData];
    [self refreshPostData];
}
-(void)refreshPostData
{
    UserModel * model =[[UserManager shareInstance]getUser];
    NSDictionary * param ;
    if ([model.patriarch isEqualToString:@"1"]&&[self.TypeStr isEqualToString:@"1"]) { 
        param =@{@"pageNum":@(self.page),@"pageRow":@"10",@"jzId":model.jzId};
    }else
    {
        param =@{@"id":model.id,@"pageNum":@(self.page),@"pageRow":@"10",@"type":@"0"};
    }
    
       
        [RequestHelp POST:selectByApply_url parameters:param success:^(id result) {
            DLog(@"%@",result);
            [self.dataAry addObjectsFromArray:[NSArray yy_modelArrayWithClass:[RZMessageModel class] json:result[@"list"]]];
            [self.tableView reloadData];
            [self endRefresh];
        } failure:^(NSError *error) {
            [self endRefresh];
        }];
}
-(void)GoLook:(UIButton *)btn
{
    RZMessageModel *model=self.dataAry[btn.tag-100];
    if ([model.state isEqualToString:@"1"]&&[self.TypeStr isEqualToString:@"2"]) {
               JZMessageViewController * fvc =[JZMessageViewController new];
                fvc.JzId=model.jzId;
                [self.navigationController pushViewController:fvc animated:YES];
    }else if ([model.state isEqualToString:@"4"]&&[self.TypeStr isEqualToString:@"1"])
    {
    }
    else
    {
        RZLookReasonViewController *CPVC=[RZLookReasonViewController new];
        CPVC.TypeStr=self.TypeStr;
          CPVC.model=model;
          [self.navigationController pushViewController:CPVC animated:YES];
    }
   
}
-(void)Gocencel:(UIButton *)btn
{
    RZMessageModel *model=self.dataAry[btn.tag-10000];
    [RequestHelp POST:update_url parameters:@{@"id":model.id,@"state":@"6"} success:^(id result) {
        ShowMessage(@"操作成功");
        [self postDate];
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
