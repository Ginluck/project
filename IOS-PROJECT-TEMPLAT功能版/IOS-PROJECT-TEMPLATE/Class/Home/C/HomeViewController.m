//
//  HomeViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2019/12/10.
//  Copyright © 2019年 梦境网络. All rights reserved.
//

#import "HomeViewController.h"
#import "CitangCell.h"
#import "HomeTableHeaderView.h"
#import "CitangListModel.h"
#import <AVFoundation/AVFoundation.h> //音频视频框架
#import "JisiProController.h"
#import "AddPersonCitangController.h"
#import "AddFamilyCitangController.h"
#import "WorshipController.h"
#import "SJActionSheet.h"
#import "NSDate+CommonDate.h"
#import "OpinionFeedBackView.h"
#import "MoneyRecordViewController.h"
#import "QiandaoView.h"
#import "SignModel.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,QiandaoViewDelegate,OpinionViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray  * dataAry ;
@property(nonatomic,assign)NSInteger  page;
@property(nonatomic,strong)HomeTableHeaderView  * headerView;
@property(nonatomic,strong)UIButton *  bgButton;
@property(nonatomic,strong)OpinionFeedBackView  * oView;
@property(nonatomic,strong)AVAudioPlayer *player;
@property(nonatomic,strong)QiandaoView * qView;
@property(nonatomic,strong)SignModel * model;
@end

@implementation HomeViewController
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
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitleView:@"祠堂"];
    [self addNavigationItemWithImageName:@"音乐图标" itemType:kNavigationItemTypeLeft action:@selector(soundClick)];
    [self.view addSubview:self.tableView];
    [self regisNib];
    self.tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self postDate];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page = self.page + 1;
        [self refreshPostData];
        
    }];
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake(Screen_Width-50, Screen_Height-K_BottomHeight-85, 30, 30);
    [button setImage:KImageNamed(@"add1") forState:UIControlStateNormal];
    button.layer.cornerRadius =15.f;
    button.layer.masksToBounds=YES;
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    
    UIButton * button1 =[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame =CGRectMake(Screen_Width-60, K_NaviHeight+10, 50, 50);
    [button1 setImage:KImageNamed(@"签到入口") forState:UIControlStateNormal];
    button1.layer.cornerRadius =15.f;
    button1.layer.masksToBounds=YES;
    [button1 addTarget:self action:@selector(qiandao) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    

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
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self.oView removeFromSuperview];
            [self.bgButton removeFromSuperview];
        } failure:^(NSError *error) {
            
        }];
    }
    else
    {
        NSDictionary * dic=@{@"launchTime":[UIUtils getCurrentTimes]};
        [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"launch_Dic"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.oView removeFromSuperview];
        [self.bgButton removeFromSuperview];
    }
}
-(void)click
{
    SJActionSheet *actionSheet = [[SJActionSheet alloc] initSheetWithTitle:nil style:SJSheetStyleDefault itemTitles:@[@"创建个人祠堂",@"创建家族私人祠堂"]];
    actionSheet.itemTextFont =MKFont(13);
    actionSheet.cancelTextFont =MKFont(13);
    actionSheet.itemTextColor =K_Prokect_MainColor;
    actionSheet.cancleTextColor=K_PROJECT_GARYTEXTCOLOR;
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        if ([title isEqualToString:@"创建个人祠堂"])
        {
            AddPersonCitangController * avc =[AddPersonCitangController new];
            avc.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:avc animated:YES];
        }
        else if ([title isEqualToString:@"创建家族私人祠堂"])
        {
            AddFamilyCitangController * avc =[AddFamilyCitangController new];
            avc.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:avc animated:YES];
        }
    }];
}
-(AVAudioPlayer *)player
{
    if (!_player) {
          NSURL *url = [[NSBundle mainBundle] URLForResource:@"bgm.mp3" withExtension:nil];
        _player =[[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    }
    return _player;
}
-(void)soundClick
{
    [self.player prepareToPlay];
    if (self.player.isPlaying) {
        [self.player pause];
    }
    else
    {
        [self.player play];
    }
}
-(HomeTableHeaderView *)headerView
{
    if (!_headerView) {
        _headerView =[[[NSBundle mainBundle] loadNibNamed:@"HomeTableHeaderView" owner:self options:nil] firstObject];
    }
    return _headerView;
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
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, K_NaviHeight, Screen_Width, Screen_Height-K_NaviHeight-K_TabbarHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView=self.headerView;
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
        UIImageView * imageV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, CGRectGetHeight(_tableView.frame))];
        imageV.image =KImageNamed(@"祠堂背景");
        _tableView.backgroundView =imageV;
        _tableView.emptyDataSetSource =self;
        _tableView.emptyDataSetDelegate=self;
        _tableView.backgroundColor =[UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

-(void)regisNib
{
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CitangCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CitangCell class])];
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
    CitangCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CitangCell class]) forIndexPath:indexPath];
    cell.selectionStyle  =UITableViewCellSeparatorStyleNone;
    cell.backgroundView .backgroundColor =[UIColor clearColor];
    cell.backgroundColor =[UIColor clearColor];
    if (self.dataAry.count) {
          [cell reloadCell:self.dataAry[indexPath.row]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataAry.count) {
        CitangListModel * model =self.dataAry[indexPath.row];
        WorshipController * jvc  =[WorshipController new];
        jvc.model =model;
        jvc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:jvc animated:YES];
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
//    UserModel * model =[[UserManager shareInstance]getUser];
//
//    if (!model.jzId.length) {
//        ShowMessage(@"您暂时还没有加入家族");
//        return;
//    }

        NSDictionary * param =@{@"pageNum":@(self.page),@"pageRow":@"10",@"status":@"0"};
        [RequestHelp POST:JS_SELECT_CTLIST_URL parameters:param success:^(id result) {
            DLog(@"%@",result);
            [self.dataAry addObjectsFromArray:[NSArray yy_modelArrayWithClass:[CitangListModel class] json:result[@"list"]]];
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
    if ([d second]>300)
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
