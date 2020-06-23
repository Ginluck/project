//
//  RecordMoneyViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/6/15.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "RecordMoneyViewController.h"
#import "HongBaoView.h"
#import "CalendarView.h"
#import "SignModel.h"
#import "NSDate+CommonDate.h"
#import "RecordMoneyCell.h"
#import "RecordModel.h"
@interface RecordMoneyViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property(nonatomic,weak)IBOutlet UILabel * moneyLabel;

@property(nonatomic,weak)IBOutlet UIButton * signButton;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray  * dataAry ;
@property(nonatomic,assign)NSInteger  page;
@property(nonatomic,strong)RecordModel*model;
@end

@implementation RecordMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitleView:@"纪念币"];
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
    
    
    //     Do any additional setup after loading the view from its nib.
}


-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, K_NaviHeight+80, Screen_Width, Screen_Height-K_NaviHeight-80) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        UIImageView * imageV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, CGRectGetHeight(_tableView.frame))];
        imageV.image =KImageNamed(@"通用背景");
        _tableView.backgroundView =imageV;
        _tableView.emptyDataSetSource =self;
        _tableView.emptyDataSetDelegate=self;
        _tableView.backgroundColor =[UIColor clearColor];
        _tableView.separatorStyle =UITableViewCellSelectionStyleGray;
        _tableView.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

-(void)regisNib
{
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RecordMoneyCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([RecordMoneyCell class])];
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
    return 71;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RecordMoneyCell class]) forIndexPath:indexPath];
    cell.selectionStyle  =UITableViewCellSeparatorStyleNone;
    cell.backgroundView .backgroundColor =[UIColor clearColor];
    cell.backgroundColor =[UIColor clearColor];
    [cell reloadCell:self.dataAry[indexPath.row]];
//    cell.detailButton.tag =indexPath.row;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return .1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    UIView * view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 30)];
//    view.backgroundColor =[UIColor clearColor];
//    UILabel * label =[[UILabel alloc]initWithFrame:CGRectMake(15, 0, Screen_Width-30, 30)];
//    [label setFont:MKBoldFont(15)];
//    label.text =@"获取与消费记录";
//    [view addSubview:label];
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
    
    NSDictionary * param =@{@"pageNum":@(self.page),@"pageRow":@"10"};
    [RequestHelp POST:JS_SELECTCOINRECORD_URL parameters:param success:^(id result) {
        DLog(@"%@",result);
        self.model =[RecordModel yy_modelWithJSON:result];
        self.moneyLabel.text =self.model.totalCurrency;
        [self.dataAry addObjectsFromArray:[NSArray yy_modelArrayWithClass:[RecordChild class] json:result[@"list"]]];
        [self.tableView reloadData];
        [self endRefresh];
    } failure:^(NSError *error) {
        [self endRefresh];
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
}

@end
