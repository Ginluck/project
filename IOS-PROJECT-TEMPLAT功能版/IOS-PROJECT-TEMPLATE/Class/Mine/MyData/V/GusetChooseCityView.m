//
//  GusetChooseCityView.m
//  HouseAssistantAPP
//
//  Created by Apple on 2019/7/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "GusetChooseCityView.h"
#import "GusetChooseCityTableViewCell.h"
#import "HelpHouseCityModel.h"
@interface GusetChooseCityView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UITableView * tableView2;
@property(nonatomic,strong)UITableView * tableView3;
@property (nonatomic ,strong)NSMutableArray  * tableViewary2;
@property (nonatomic ,strong)NSMutableArray  * tableViewary3;
@property (nonatomic ,strong)NSMutableArray  * tableViewary1;
@property (nonatomic ,assign)NSInteger  index1;
@property (nonatomic ,assign)NSInteger  index2;
@property (nonatomic ,assign)NSInteger  index3;
@end
@implementation GusetChooseCityView
- (void)awakeFromNib {
    [super awakeFromNib];
    [self addSubview:self.tableView];
    [self addSubview:self.tableView2];
    [self addSubview:self.tableView3];
    [self request];
    _index1=0;
    _index2=0;
    _index3=0;
}
-(void)request
{
    WS(weakSelf);
    [RequestHelp POST:SELECT_PROVINCE_URL parameters:@{} success:^(id result) {
        DLog(@"result %@",result);
        [weakSelf.tableViewary1 addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HelpHouseCityModel class] json:result[@"list"]]];
            [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
-(void)requestShi:(NSString *)strid
{
    WS(weakSelf);
    [self.tableViewary2 removeAllObjects];
    [RequestHelp POST:SELECT_CITY_URL parameters:@{@"code_p":strid} success:^(id result) {
        [weakSelf.tableViewary2 addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HelpHouseCityModel class] json:result[@"list"]]];
        [weakSelf.tableView2 reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}
-(void)requestXian:(NSString *)strid
{
    WS(weakSelf);
    [self.tableViewary3 removeAllObjects];
    [RequestHelp POST:SELECT_AREA_URL parameters:@{@"code_c":strid} success:^(id result) {
        [weakSelf.tableViewary3 addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HelpHouseCityModel class] json:result[@"list"]]];
        [weakSelf.tableView3 reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width/3,  (Screen_Height-kNavagationBarH-kBottomLayout)/2)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = [UIColor clearColor];
        if (@available(iOS 11, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GusetChooseCityTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([GusetChooseCityTableViewCell class])];
        
    }
    return _tableView;
}
- (UITableView *)tableView2
{
    if (!_tableView2)
    {
        _tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(Screen_Width/3, 0, Screen_Width/3,  (Screen_Height-kNavagationBarH-kBottomLayout)/2)];
        _tableView2.delegate = self;
        _tableView2.dataSource = self;
        _tableView2.showsVerticalScrollIndicator = NO;
        _tableView2.separatorColor = [UIColor clearColor];
        if (@available(iOS 11, *)) {
            _tableView2.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        [_tableView2 registerNib:[UINib nibWithNibName:NSStringFromClass([GusetChooseCityTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([GusetChooseCityTableViewCell class])];
        
    }
    return _tableView2;
}
- (UITableView *)tableView3
{
    if (!_tableView3)
    {
        _tableView3 = [[UITableView alloc] initWithFrame:CGRectMake(Screen_Width*2/3, 0, Screen_Width/3, (Screen_Height-kNavagationBarH-kBottomLayout)/2)];
        _tableView3.delegate = self;
        _tableView3.dataSource = self;
        _tableView3.showsVerticalScrollIndicator = NO;
        _tableView3.separatorColor = [UIColor clearColor];
        if (@available(iOS 11, *)) {
            _tableView3.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        [_tableView3 registerNib:[UINib nibWithNibName:NSStringFromClass([GusetChooseCityTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([GusetChooseCityTableViewCell class])];
        
    }
    return _tableView3;
}
-(NSMutableArray *)tableViewary3
{
    if (!_tableViewary3) {
        _tableViewary3=[[NSMutableArray alloc]init];
    }
    return _tableViewary3;
}
-(NSMutableArray *)tableViewary2
{
    if (!_tableViewary2) {
        _tableViewary2=[[NSMutableArray alloc]init];
    }
    return _tableViewary2;
}
-(NSMutableArray *)tableViewary1
{
    if (!_tableViewary1) {
        _tableViewary1=[[NSMutableArray alloc]init];
    }
    return _tableViewary1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_tableView) {
        return _tableViewary1.count;
    }
    else if (tableView==_tableView2){
        return _tableViewary2.count;
    }
    else
    {
        return _tableViewary3.count;
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView ==_tableView) {
        GusetChooseCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GusetChooseCityTableViewCell class]) forIndexPath:indexPath];
        [cell setModel:_tableViewary1[indexPath.row]];
        cell.selectionStyle  =UITableViewCellSeparatorStyleNone;
        return cell;
    }else if (tableView ==_tableView2) {
        GusetChooseCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GusetChooseCityTableViewCell class]) forIndexPath:indexPath];
        [cell setModel:_tableViewary2[indexPath.row]];
        cell.selectionStyle  =UITableViewCellSeparatorStyleNone;
        return cell;
    }
    else
    {
        GusetChooseCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GusetChooseCityTableViewCell class]) forIndexPath:indexPath];
        [cell setModel:_tableViewary3[indexPath.row]];
        cell.selectionStyle  =UITableViewCellSeparatorStyleNone;
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView== self.tableView) {
        _index1=indexPath.row;
        HelpHouseCityModel *model =self.tableViewary1[indexPath.row];
        [self requestShi:model.code_p];
        [self.tableViewary3 removeAllObjects];
        [self.tableView3 reloadData];
    }else if(tableView==self.tableView2)
    {
        _index2=indexPath.row;
        HelpHouseCityModel *model =self.tableViewary2[indexPath.row];
        [self requestXian:model.code_c];
    }
    else
    {
        _index3=indexPath.row;
        HelpHouseCityModel *model1 =self.tableViewary1[_index1];
        HelpHouseCityModel *model2 =self.tableViewary2[_index2];
        HelpHouseCityModel *model3 =self.tableViewary3[_index3];
        if (self.CMBlock) {
            self.CMBlock(model1.code_p, model1.name, model2.code_c, model2.name, model3.code_a, model3.name);
        }
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
