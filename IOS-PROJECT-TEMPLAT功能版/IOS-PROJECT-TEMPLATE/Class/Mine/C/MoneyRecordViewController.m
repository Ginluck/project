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
#import "SignModel.h"
#import "ShareView.h"
@interface MoneyRecordViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,shareViewDelegate,DZNEmptyDataSetDelegate,moneyCellDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray  * dataAry ;
@property(nonatomic,assign)NSInteger  page;

@property(nonatomic,strong)CalendarView * cView;
@property(nonatomic,strong)ShareView * sView;
@property(nonatomic,strong)UIButton *  bgButton;
@property(nonatomic,strong)SignModel *  model;
@end

@implementation MoneyRecordViewController

-(void)moneyBtnClick:(UIButton *)sender;
{
    SigninChild *model =self.model.additionalSignIn[sender.tag];
    [RequestHelp POST:JS_GETREWARD_URL parameters:@{@"consecutiveDays":model.consecutiveDays} success:^(id result) {
        ShowMessage(result);
        [self requestData];
    } failure:^(NSError *error) {
        
    }];
}
-(void)signBtnClick:(UIButton *)sender
{
    [RequestHelp POST:JS_SIGNIN_URL parameters:@{} success:^(id result) {
        ShowMessage(result);
        [self requestData];
    } failure:^(NSError *error) {
    }];

}
-(void)shareViewBtnClick:(UIButton *)button
{
    [self buttonClick];
    UserModel * model =[[UserManager shareInstance]getUser];
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    pab.string = [NSString stringWithFormat:@"复制整段，打开【祭念app】 我的邀请码：%@",model.yqm];
    
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

-(void)inviteBtnClick
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgButton];
    [self.bgButton addSubview:self.sView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self regisNib];
    [self addNavigationTitleView:@"纪念币"];
    [self requestData];
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,kNavagationBarH, Screen_Width, Screen_Height-kNavagationBarH) style:UITableViewStyleGrouped];
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
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MoneyCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MoneyCell class])];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 600;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MoneyCell class]) forIndexPath:indexPath];
    cell.selectionStyle  =UITableViewCellSeparatorStyleNone;
    cell.backgroundColor =[UIColor clearColor];
    cell.delegate=self;
    [cell reloadCell:self.model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 60;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 60)];
    view.backgroundColor =[UIColor whiteColor];
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake(5, 6, Screen_Width-10, 48);
    button.backgroundColor =K_Prokect_MainColor;
    button.layer.cornerRadius=24;
    button.layer.masksToBounds=YES;
    [button setTitle:@"邀 请 好 友" forState:UIControlStateNormal];
    [button.titleLabel setFont:MKFont(18)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(inviteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    return view;
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
-(void)requestData
{
    ShowMaskStatus(@"加载数据中");
    [RequestHelp POST:JS_SIGNRECORD_URL parameters:@{} success:^(id result) {
        MKLog(@"%@",result);
        DismissHud();
        self.model  =[SignModel yy_modelWithJSON:result];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        DismissHud();
    }];
}



@end
