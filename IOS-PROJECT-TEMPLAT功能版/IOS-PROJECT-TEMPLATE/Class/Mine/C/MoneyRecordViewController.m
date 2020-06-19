//
//  MoneyRecordViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/6/11.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "MoneyRecordViewController.h"
#import "MoneyCell.h"
#import "MoneyView.h"
#import "CalendarView.h"
#import "NSDate+CommonDate.h"

#import "ShareView.h"
@interface MoneyRecordViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,shareViewDelegate,DZNEmptyDataSetDelegate,moneyViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray  * dataAry ;
@property(nonatomic,assign)NSInteger  page;
@property(nonatomic,strong)MoneyView * mView;
@property(nonatomic,strong)CalendarView * cView;
@property(nonatomic,strong)ShareView * sView;
@property(nonatomic,strong)UIButton *  bgButton;
@end

@implementation MoneyRecordViewController


-(void)shareViewBtnClick:(UIButton *)button
{
    [self buttonClick];
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    pab.string = @"复制整段，打开【祭念app】 我的邀请码：698826586";
    
    NSString * message;
    if (button.tag ==99)
    {
         message =@"邀请码已复制完成，确定要复制邀请码到qq吗";
    }
    else
    {
       message =@"邀请码已复制完成,确定要复制邀请码到微信吗";
    }
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                              if (button.tag ==99) {
                                                                  [self openqq];
                                                              }
                                                              else
                                                              {
                                                                  [self openWechat];
                                                              }
                                                              
                                                          }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             
                                                         }];
    
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)openWechat{
    
    NSURL * url = [NSURL URLWithString:@"weixin://"];
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
    //先判断是否能打开该url
    if (canOpen)
    {   //打开微信
        [[UIApplication sharedApplication] openURL:url];
    }else {
        ShowMessage(@"您的设备未安装微信APP");
    }
}
-(void)openqq
{
    NSURL * url = [NSURL URLWithString:@"mqq://"];
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
    //先判断是否能打开该url
    if (canOpen)
    {   //打开微信
        [[UIApplication sharedApplication] openURL:url];
    }else {
        ShowMessage(@"您的设备未安装QQAPP");
    }
}

-(ShareView*)sView
{
    if (!_sView) {
        _sView =[[[NSBundle mainBundle] loadNibNamed:@"ShareView" owner:self options:nil] firstObject];
        _sView.frame =CGRectMake(0, Screen_Height-100, Screen_Width, 100);
        _sView.delegate =self;
    }
    return _sView;
}
-(UIButton *)bgButton
{
    if (!_bgButton) {
        _bgButton =[UIButton buttonWithType:UIButtonTypeCustom];
        _bgButton .frame =CGRectMake(0, 0, Screen_Width, Screen_Height);
        _bgButton.backgroundColor =COLOR(0, 0, 0, 0.6);
        [_bgButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgButton;
}
-(MoneyView *)mView
{
    if (!_mView) {
        _mView =[[[NSBundle mainBundle] loadNibNamed:@"MoneyView" owner:self options:nil] firstObject];
        _mView.frame =CGRectMake(0, 0, Screen_Width, Screen_Height-K_NaviHeight);
        _mView.delegate =self;
    }
    return _mView;
}
-(void)inviteBtnClick
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgButton];
    [self.bgButton addSubview:self.sView];
}
-(void)calendarBtnClick
{
    NSMutableArray * ary =[NSMutableArray array];
    for (int i=0; i<5; i++)
    {
        NSString * str =[NSString stringWithFormat:@"2020-06-1%d",i];
        NSDate * date =[NSDate dateWithFormat:@"yyyy-MM-dd" dateString:str];
        [ary addObject:date];
    }
    self.cView.selectedAry =ary;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgButton];
    [self.bgButton addSubview:self.cView];
}
//-(CalendarView *)cView
//{
//    if (!_cView) {
//        _cView =[[CalendarView alloc]initWithFrame:CGRectMake(0, 0, 280, 280)];
//        _cView.center =CGPointMake(Screen_Width/2, Screen_Height/2);
//    }
//    return _cView;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.mView.frame =CGRectMake(0, 0, Screen_Width, Screen_Height-K_NaviHeight);
    [self.view addSubview:self.mView];
//    [self.view addSubview:self.tableView];
//    [self regisNib];
    [self addNavigationTitleView:@"纪念币"];
//    self.tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self postDate];
//    }];
//    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        self.page = self.page + 1;
//        [self refreshPostData];
//
//    }];
    // Do any additional setup after loading the view from its nib.
}

-(void)buttonClick
{
    [self.sView removeFromSuperview];
    
    [self.cView removeFromSuperview];
    
    [self.bgButton removeFromSuperview];
}
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, K_NaviHeight, Screen_Width, Screen_Height-K_NaviHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView=self.mView;
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
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MoneyCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MoneyCell class])];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MoneyCell class]) forIndexPath:indexPath];
    cell.selectionStyle  =UITableViewCellSeparatorStyleNone;
    cell.backgroundColor =[UIColor clearColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 30)];
    UILabel * lab =[[UILabel alloc]initWithFrame:CGRectMake(20, 0, Screen_Width-40, 30)];
    lab.font =MKFont(15);
    lab.textColor =[UIColor blackColor];
    lab.text =@"纪念币获取记录";
    [view addSubview:lab];
    return view;
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
//    NSDictionary * param =@{@"pageNum":@(self.page),@"pageRow":@"10",@"status":@"0",@"jzId":model.jzId,@"ctId":@""};
//    [RequestHelp POST:selectAppRechargeRecord parameters:param success:^(id result) {
//        DLog(@"%@",result);
//        [self.dataAry addObjectsFromArray:[NSArray yy_modelArrayWithClass:[GongFengListModel class] json:result[@"list"]]];
//        [self setupNotData];
//        [self.tableView reloadData];
//        [self endRefresh];
//    } failure:^(NSError *error) {
//        [self endRefresh];
//    }];
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
