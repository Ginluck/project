//
//  GongPinDetialViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/11.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "GongPinDetialViewController.h"
#import "GongPinDetialTopView.h"
#import "TravelWebTableViewCell.h"
#import "ShopPopView.h"
#import "AddOrderViewController.h"
@interface GongPinDetialViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)GongPinDetialTopView *HHView;
@property(nonatomic,strong)ShopPopView *SPView;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIView *BgView;
@end

@implementation GongPinDetialViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView=self.HHView;
    [self regisNib];
    [self SetBg];
   
    // Do any additional setup after loading the view from its nib.
}
-(GongPinDetialTopView *)HHView
{
    if (!_HHView) {
        _HHView=[[NSBundle mainBundle]loadNibNamed:@"GongPinDetialTopView" owner:nil options:nil][0];
        _HHView.frame =CGRectMake(0, kNavagationBarH, Screen_Width, 334);
        
       
    }
    return _HHView;
}
-(ShopPopView *)SPView
{
    if (!_SPView) {
        _SPView=[[NSBundle mainBundle]loadNibNamed:@"ShopPopView" owner:nil options:nil][0];
        _SPView.frame =CGRectMake(0, Screen_Height, Screen_Width, 500);
         [_SPView.CloseBtn addTarget:self action:@selector(deleteView) forControlEvents:UIControlEventTouchUpInside];
         [_SPView.BuyBtn addTarget:self action:@selector(GoNextView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _SPView;
}
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavagationBarH, Screen_Width, Screen_Height-kNavagationBarH-50-kBottomLayout) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor =kBGViewCOLOR;
        _tableView.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}
-(void)SetBg
{
    _BgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 0)];
       _BgView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
       UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
       [keyWindow addSubview:self.BgView];
       [self.BgView addSubview:self.SPView];
    UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-500)];
    [btn addTarget:self action:@selector(deleteView) forControlEvents:UIControlEventTouchUpInside];
    [self.BgView addSubview:btn];
}
-(void)regisNib
{
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TravelWebTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TravelWebTableViewCell class])];
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
      NSLog(@"%f",[TravelWebTableViewCell cellHeight]);
           return 60+[TravelWebTableViewCell cellHeight];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WS(weakSelf);
           TravelWebTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TravelWebTableViewCell class]) forIndexPath:indexPath];
           cell.selectionStyle  =UITableViewCellSeparatorStyleNone;
          
//               [cell setHtmlString:self.DModel.link1];
           cell.reloadBlock =^()
           {
               [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
           };
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

- (IBAction)Add:(id)sender {
    self.BgView.frame =CGRectMake(0, 0, Screen_Width, Screen_Height);
    [UIView animateWithDuration:0.3 animations:^{
        self.SPView.frame =CGRectMake(0, Screen_Height-500, Screen_Width, 500);
       }];
}
- (IBAction)Buy:(id)sender {
    self.BgView.frame =CGRectMake(0, 0, Screen_Width, Screen_Height);
    [UIView animateWithDuration:0.3 animations:^{
        self.SPView.frame =CGRectMake(0, Screen_Height-500, Screen_Width, 500);
    }];
}
-(void)deleteView
{
     self.BgView.frame =CGRectMake(0, 0, Screen_Width, 0);
    [UIView animateWithDuration:0.3 animations:^{
        self.SPView.frame =CGRectMake(0, Screen_Height, Screen_Width, 500);
    }];
}
-(void)GoNextView
{
    [self deleteView];
    AddOrderViewController *AOVC=[AddOrderViewController new];
    [self.navigationController pushViewController:AOVC animated:YES];
}
-(void)refreshPostData
{
    
    //    NSDictionary * param =@{@"pageNum":@(self.page),@"pageRow":@"10",@"status":@"1",@"isApp":@"1"};
    //    [RequestHelp POST:GET_HOUSESALE_URL parameters:param success:^(id result) {
    //        DLog(@"%@",result);
    //        [self.dataAry addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HouseSaleInfo class] json:result[@"list"]]];
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
