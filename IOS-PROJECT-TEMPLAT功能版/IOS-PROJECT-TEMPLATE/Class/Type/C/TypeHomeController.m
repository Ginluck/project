//
//  TypeHomeController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2019/12/10.
//  Copyright © 2019年 梦境网络. All rights reserved.
//

#import "TypeHomeController.h"
#import "SignModel.h"
#import "FamilyDetailController.h"
#import "CitangCell.h"
#import "ZupuHomeCell.h"
#import "FamilyListModel.h"
#import "CitangHeaderView.h"
#import "MoneyRecordViewController.h"
#import "NSDate+CommonDate.h"
#import "OpinionFeedBackView.h"
#import "QiandaoView.h"
@interface TypeHomeController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,QiandaoViewDelegate,OpinionViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray  * dataAry ;
@property(nonatomic,assign)NSInteger  page;
@property(nonatomic,strong)CitangHeaderView * headerView;
@property(nonatomic,strong)UIButton *  bgButton;
@property(nonatomic,strong)OpinionFeedBackView  * oView;
@property(nonatomic,strong)QiandaoView * qView;
@property(nonatomic,strong)SignModel * model;
@end

@implementation TypeHomeController
-(UIButton *)bgButton
{
    if (!_bgButton) {
        _bgButton =[UIButton buttonWithType:UIButtonTypeCustom];
        _bgButton .frame =CGRectMake(0, 0, Screen_Width, Screen_Height);
        _bgButton.backgroundColor =COLOR(0, 0, 0, 0.6);
        //        [_bgButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgButton;
}
-(OpinionFeedBackView *)oView
{
    if (!_oView) {
        _oView =[[[NSBundle mainBundle] loadNibNamed:@"OpinionFeedBackView" owner:self options:nil] firstObject];
        _oView.frame =CGRectMake(0, 0, 240, 320);
        _oView.center =CGPointMake(Screen_Width/2, Screen_Height/2);
        _oView.delegate =self;
    }
    return _oView;
}
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
    
    UIButton * button1 =[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame =CGRectMake(Screen_Width-60, K_NaviHeight+10, 50, 50);
    [button1 setImage:KImageNamed(@"签到入口") forState:UIControlStateNormal];
    button1.layer.cornerRadius =15.f;
    button1.layer.masksToBounds=YES;
    [button1 addTarget:self action:@selector(qiandao) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    

//     Do any additional setup after loading the view from its nib.
}



-(void)qiandaoClose
{
    [self.bgButton removeFromSuperview];
    [self.qView removeFromSuperview];
}
-(void)qiandaoClick
{
    [RequestHelp POST:JS_SIGNIN_URL parameters:@{} success:^(id result) {
        ShowMessage(result);
        [self qiandaoClose];
    } failure:^(NSError *error) {
    }];
}
-(void)hongbaoClick:(UIButton *)sender
{
    SigninChild *model =self.model.additionalSignIn[sender.tag];
    [RequestHelp POST:JS_GETREWARD_URL parameters:@{@"consecutiveDays":model.consecutiveDays} success:^(id result) {
        ShowMessage(result);
        [self qiandaoClose];
    } failure:^(NSError *error) {
    }];
}
-(void)qiandao
{
    ShowMaskStatus(@"加载数据中");
    [RequestHelp POST:JS_SIGNRECORD_URL parameters:@{} success:^(id result) {
        MKLog(@"%@",result);
        DismissHud();
        self.model  =[SignModel yy_modelWithJSON:result];
        [[UIApplication sharedApplication].keyWindow addSubview:self.bgButton];
        self.qView.model =self.model;
        [self.bgButton addSubview:self.qView];
        
    } failure:^(NSError *error) {
        DismissHud();
    }];
}
-(QiandaoView *)qView
{
    if (!_qView) {
        _qView =[[[NSBundle mainBundle] loadNibNamed:@"QiandaoView" owner:self options:nil] firstObject];
        _qView.delegate =self;
        _qView.frame =CGRectMake(0, 0, 280, 386);
        _qView.center =CGPointMake(Screen_Width/2, Screen_Height/2);
    }
    return _qView;
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


-(void)opinionViewClick:(UIButton *)button
{
    if (button.tag ==9)
    {
        UserModel * model =[[UserManager shareInstance]getUser];
        if (!self.oView.feedView.text.length) {
            ShowMessage(@"请输入反馈意见");return;
        }
        [RequestHelp POST:JS_FEEDBACK_URL parameters:@{@"content":self.oView.feedView.text,@"userUserId":model.id,@"type":@"1"} success:^(id result) {
            DLog(@"%@",result);
            ShowMessage(@"反馈成功");
            NSDictionary * dic=@{@"launchTime":[UIUtils getCurrentTimes]};
            [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"launch_Dic"];
            [self.oView removeFromSuperview];
            [self.bgButton removeFromSuperview];
        } failure:^(NSError *error) {
            
        }];
    }
    else
    {
        NSDictionary * dic=@{@"launchTime":[UIUtils getCurrentTimes]};
        [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"launch_Dic"];
        [self.oView removeFromSuperview];
        [self.bgButton removeFromSuperview];
    }
}

-(void)regisNib
{
  [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZupuHomeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ZupuHomeCell class])];
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
    ZupuHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZupuHomeCell class]) forIndexPath:indexPath];
    cell.selectionStyle  =UITableViewCellSeparatorStyleNone;
    cell.backgroundView .backgroundColor =[UIColor clearColor];
    cell.backgroundColor =[UIColor clearColor];
    if (self.dataAry.count) {
        [cell reloadCell:self.dataAry[indexPath.row]];
        cell.detailButton.tag =indexPath.row;
        [cell.detailButton addTarget:self action:@selector(detailClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}
-(void)detailClick:(UIButton *)sender
{
    if (self.dataAry.count) {
        FamilyListModel * model =self.dataAry[sender.tag];
        FamilyDetailController * fvc =[FamilyDetailController new];
        fvc.hidesBottomBarWhenPushed =YES;
        fvc.model =model;
        [self.navigationController pushViewController:fvc animated:YES];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataAry.count) {
        FamilyListModel * model =self.dataAry[indexPath.row];
        FamilyDetailController * fvc =[FamilyDetailController new];
        fvc.hidesBottomBarWhenPushed =YES;
        fvc.model =model;
        [self.navigationController pushViewController:fvc animated:YES];
    }
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
    [self.tableView reloadData];
    [self refreshPostData];
}
-(void)refreshPostData
{
    NSDictionary * param =@{@"pageNum":@(self.page),@"pageRow":@"10",@"status":@"0"};
    [RequestHelp POST:JS_FAMILY_LIST_URL parameters:param success:^(id result) {
        DLog(@"%@",result);
        [self.dataAry addObjectsFromArray:[NSArray yy_modelArrayWithClass:[FamilyListModel class] json:result[@"list"]]];
        if (self.dataAry.count==0) {
            [self.tabBarController setSelectedIndex:2];
            return ;
        }
        [self refreshOUTView];
        [self.tableView reloadData];
        [self endRefresh];
    } failure:^(NSError *error) {
        [self endRefresh];
    }];
}
-(void)refreshOUTView
{
    //      NSDictionary * launchDic =@{@"launchTime":launchTime,@"isOut":@"0"};
    NSDictionary * dic =[[NSUserDefaults standardUserDefaults]objectForKey:@"launch_Dic"];
    //    NSCalendarUnitYear| NSCalendarUnitMonth| NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|
    NSString  * oldTime =dic[@"launchTime"];
    NSString *  nTime =[UIUtils getCurrentTimes];
    
    NSDate * oldDate =[NSDate dateWithFormat:@"yyyy-MM-dd HH:mm:ss" dateString:oldTime];
    NSDate * nDate =[NSDate dateWithFormat:@"yyyy-MM-dd HH:mm:ss" dateString:nTime];
    NSCalendar *cal=[NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitSecond;
    NSDateComponents *d = [cal components:unitFlags fromDate:oldDate toDate:nDate options:0];
    if ([d second]>15)
    {
        [self requestData];
    }
}


-(void)requestData
{
    [RequestHelp POST:JS_ISFEEDBACK_URL parameters:@{} success:^(id result) {
        NSInteger value =[result integerValue];
        if (value>0)
        {
            return ;
        }
        else
        {
            [[[UIApplication sharedApplication]keyWindow]addSubview:self.bgButton];
            [self.bgButton addSubview:self.oView];
        }
    } failure:^(NSError *error) {}];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [self postDate];
}
@end
