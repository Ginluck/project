//
//  ChooseMemberController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/28.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "ChooseMemberController.h"
#import "FamilyTreeCell.h"
#import "FamilyTreeModel.h"
@interface ChooseMemberController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,FamilyCellClickDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray  * dataAry ;
@property(nonatomic,assign)NSInteger  page;
@property(nonatomic,strong)NSMutableArray  * selectAry ;
@property(nonatomic,strong)UIImagePickerController *imagePickerVC;
@end

@implementation ChooseMemberController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitleView:@"族谱"];
    [self.view addSubview:self.tableView];
    [self regisNib];
    [self postDate];
    [self createUICompeonts];
}

-(void)createUICompeonts
{
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake(0, Screen_Height-40, Screen_Width, 40);
    button.backgroundColor =K_Prokect_MainColor;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

-(void)confirm
{
    NSMutableArray * ar =[NSMutableArray array];
    for (FamilyTreeModel* model in self.dataAry)
    {
        for (FamilyTreeMember * member in model.list)
        {
            if ([member.isSelected isEqualToString:@"1"])
            {
                member.count =model.count;
                [ar addObject:member];
            }
        }
    }
    if (ar.count ==0) {
        ShowMessage(@"请先选择要祭祀的成员");return;
    }
    self.block(ar);
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSMutableArray *)selectAry
{
    if (!_selectAry) {
        _selectAry =[NSMutableArray array];
    }
    return _selectAry;
}
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, K_NaviHeight, Screen_Width, Screen_Height-K_NaviHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        UIImageView * imageV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, CGRectGetHeight(_tableView.frame))];
        imageV.image =KImageNamed(@"通用背景");
        _tableView.backgroundView =imageV;
        _tableView.emptyDataSetSource =self;
        _tableView.emptyDataSetDelegate=self;
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
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
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FamilyTreeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([FamilyTreeCell class])];
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
    
    return 80;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FamilyTreeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FamilyTreeCell class]) forIndexPath:indexPath];
    cell.backgroundView .backgroundColor =[UIColor clearColor];
    cell.backgroundColor =[UIColor clearColor];
    FamilyTreeModel *model =self.dataAry[indexPath.row];
    [cell setCell:model.list index:indexPath.row];
    cell.delegate=self;
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

-(void)familyBtnClick:(FamliyTreeButton *)button
{
    FamilyTreeModel *model =self.dataAry[button.row];
    FamilyTreeMember * member=(FamilyTreeMember*)model.list[button.tag];
    if ([member.isSelected isEqualToString:@"1"]) {
        member.isSelected =@"0";
    }
    else
    {
        member.isSelected =@"1";
    }
    [self.tableView reloadData];
    
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
    
    NSDictionary * param =@{@"jzId":self.model.id,@"firstGeneration":@"1",@"state":@"1"};
    [RequestHelp POST:JS_SELECT_ZPLIST_URL parameters:param success:^(id result) {
        DLog(@"%@",result);
        [self.dataAry addObjectsFromArray:[NSArray yy_modelArrayWithClass:[FamilyTreeModel class] json:result]];
        if (self.selctedArr.count) {
            for (FamilyTreeModel* model in self.dataAry)
            {
                for (FamilyTreeMember * member in model.list)
                {
                    for (FamilyTreeMember * mem in self.selctedArr) {
                        
                        if ([member.id isEqualToString:mem.id])
                        {
                            member.isSelected =@"1";
                        }
                    }
                }
            }
        }
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
