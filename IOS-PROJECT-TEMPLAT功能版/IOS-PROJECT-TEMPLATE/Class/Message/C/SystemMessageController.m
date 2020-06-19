//
//  SystemMessageController.m
//  RentHouseApp
//
//  Created by ginluck on 2019/7/24.
//  Copyright © 2019年 Apple. All rights reserved.
//

#import "SystemMessageController.h"
#import "MessageListTableViewCell.h"
#import "MessageListModel.h"
#import "NSString+Fit.h"

@interface SystemMessageController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray  * dataAry;
@property (assign, nonatomic) NSInteger page;
@end

@implementation SystemMessageController
-(NSMutableArray *)dataAry
{
    if (!_dataAry) {
        _dataAry=[[NSMutableArray alloc]init];
    }
    return _dataAry;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitleView:@"系统消息"];
    [self.view addSubview:self.tableView];

       self.tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
           [self postdata];
       }];
       self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
           self.page = self.page + 1;
           [self refreshPostData];
           
       }];
    // Do any additional setup after loading the view.
}
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, K_NaviHeight, Screen_Width, Screen_Height-kNavagationBarH ) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource =self;
        _tableView.emptyDataSetDelegate=self;
        UIImageView * imageV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, CGRectGetHeight(_tableView.frame))];
        imageV.image =KImageNamed(@"通用背景");
        _tableView.backgroundView =imageV;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = [UIColor clearColor];
        if (@available(iOS 11, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MessageListTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MessageListTableViewCell class])];
        
    }
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataAry.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageListModel * model =self.dataAry[indexPath.section];
    if ([model.isOpen isEqualToString:@"1"])
    {
        CGFloat height =[model.content getHeightWithFont:13.f withWidth:Screen_Width-83];
        return 80-12+height;
    }
    else
    {
            return 80;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   MessageListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MessageListTableViewCell class]) forIndexPath:indexPath];
    cell.backgroundView .backgroundColor =[UIColor clearColor];
    cell.backgroundColor =[UIColor clearColor];
    cell.selectionStyle  =UITableViewCellSeparatorStyleNone;
   [cell refreshSystem:self.dataAry[indexPath.section]];
   return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30.f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    MessageListModel * model =self.dataAry[section];
    UIView * view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 30)];
    UIButton * button =[UIButton  buttonWithType:UIButtonTypeCustom];
    button.tag =section;
    button.backgroundColor =[UIColor whiteColor];
    button.frame =CGRectMake(0, 0, Screen_Width, 30);
    if ([model.isOpen isEqualToString:@"1"]) {
        [button setTitle:@"收起" forState:UIControlStateNormal];
    }
   else
   {
        [button setTitle:@"查看更多" forState:UIControlStateNormal];
   }
    button.titleLabel.font =[UIFont systemFontOfSize:13.f];
    button.titleLabel.textAlignment =NSTextAlignmentRight;
    [button setTitleColor:COLOR_HEX(0X02B7E6) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showUp:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    return view;
}
-(void)showUp:(UIButton *)button
{
    MessageListModel * model =self.dataAry[button.tag];
    if ([model.isOpen isEqualToString:@"1"])
    {
        model.isOpen =@"0";
    }
    else
    {
        model.isOpen =@"1";
    }
    [self.tableView reloadData];
}
-(void)endRefresh
{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
-(void)postdata
{
    self.page = 1;
    [self.dataAry removeAllObjects];
    [self refreshPostData];
}
-(void)refreshPostData
{
    WS(weakSelf);
    NSDictionary * param =@{@"pageRow":@"10",@"pageNum":[NSString stringWithFormat:@"%ld",(long)self.page]};
    [RequestHelp POST:JS_SYSMESSAGE_LILST_URL parameters:param success:^(id result) {
        DLog(@"%@",result);
        [weakSelf.dataAry addObjectsFromArray:[NSArray yy_modelArrayWithClass:[MessageListModel class] json:result[@"list"]]];
        [self.tableView reloadData];
        [self endRefresh];
    } failure:^(NSError *error) {
         [self endRefresh];
    }];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"无数据"];
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self postdata];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
@end
