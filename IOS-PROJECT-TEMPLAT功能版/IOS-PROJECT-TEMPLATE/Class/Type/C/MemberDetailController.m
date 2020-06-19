//
//  MemberDetailController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/9.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "MemberDetailController.h"
#import "MemberDetailInfoCell.h"
#import "JYEqualCellSpaceFlowLayout.h"
#import "MemberDetailGuanxiCell.h"
#import "CollectionHeaderView.h"
#import "MemberDetailModel.h"
#import "MemberDetailChild.h"

@interface MemberDetailController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,weak)IBOutlet UIImageView * memberImage;
@property(nonatomic,weak)IBOutlet UILabel * memberName;
@property(nonatomic,weak)IBOutlet UIImageView * memberSexy;

@property(nonatomic,weak)IBOutlet UIButton * infoBtn;
@property(nonatomic,weak)IBOutlet UIButton * guanxiBtn;
@property(nonatomic,strong)MemberDetailModel * model;
@property(nonatomic,weak)IBOutlet UIView * midView;
@property(nonatomic,weak)IBOutlet UIView * bottomView;
@property(nonatomic,strong) UIView * redView;

@property(nonatomic,strong) UITableView * tableView;
@property(nonatomic,strong) UICollectionView * collectionView;
@end

@implementation MemberDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUICompoents];
    [self refreshPostData];

}
-(void)setUICompoents
{
    self.KNavHeight.constant=kNavagationBarH;
    [self.KNavView setNeedsLayout];
    [self.midView addSubview:self.redView];
    [self.bottomView addSubview:self.tableView];
    [self regisNib];
  
}
#pragma mark tableview
-(void)regisNib
{
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MemberDetailInfoCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MemberDetailInfoCell class])];
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
    return 400;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MemberDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MemberDetailInfoCell class]) forIndexPath:indexPath];
    cell.selectionStyle  =UITableViewCellSeparatorStyleNone;
    [cell refresh:self.model];
    return cell;
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

-(IBAction)btnClick:(UIButton *)sender
{
    [self.infoBtn setTitleColor:K_Prokect_MainColor forState:UIControlStateNormal];
    [self.guanxiBtn setTitleColor:K_Prokect_MainColor forState:UIControlStateNormal];
    [sender setTitleColor:COLOR_HEX(0x9d1811) forState:UIControlStateNormal];
    if (sender.tag ==10)
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.redView.frame =CGRectMake(0, 39, Screen_Width/2, 1);
        }];
        [self.collectionView removeFromSuperview];
        [self.bottomView addSubview:self.tableView];
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.redView.frame =CGRectMake(Screen_Width/2, 39, Screen_Width/2, 1);
        }];
        [self.tableView removeFromSuperview];
        [self.bottomView addSubview:self.collectionView];
    }
    
}




-(UIView *)redView
{
    if (!_redView) {
        _redView =[[UIView alloc]initWithFrame:CGRectMake(0, 39, Screen_Width/2, 1)];
        _redView.backgroundColor =COLOR_HEX(0x9d1811);
    }
    return _redView;
}
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, CGRectGetHeight(self.bottomView.frame)) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource =self;
        _tableView.emptyDataSetDelegate=self;
        _tableView.backgroundColor =[UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        JYEqualCellSpaceFlowLayout * flowLayout = [[JYEqualCellSpaceFlowLayout alloc]initWithType:AlignWithLeft betweenOfCell:0.0];
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, CGRectGetHeight(self.bottomView.frame)) collectionViewLayout:flowLayout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.backgroundColor=[UIColor whiteColor];
        
        // 注册
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MemberDetailGuanxiCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MemberDetailGuanxiCell class])];
        
//        [_collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeaderView"];
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CollectionHeaderView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeaderView"];
    
    }return _collectionView;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSArray * arr =self.model.homeList [section];
    return arr.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake(Screen_Width/2,80);
    
}

#pragma mark - 头部视图大小
//第二步
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    CGSize size = CGSizeMake(Screen_Width, 35);
    return size;
}
#pragma mark - 头部视图内容
//第三步
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusableView = nil;
    
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        CollectionHeaderView *headerView = (CollectionHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeaderView" forIndexPath:indexPath];
        
         NSArray * arr =self.model.homeList [indexPath.section];
        MemberDetailChild * member;
        if (arr.count) {
            member =arr[0];
            if ([member.type isEqualToString:@"0"]) {
                headerView.textTitleLab.text = @"父母";
            }else  if ([member.type isEqualToString:@"1"]){
                headerView.textTitleLab.text = @"配偶";
            }else{
                headerView.textTitleLab.text = @"子女";
            }
        }
        
     
        reusableView = headerView;
    }
    return reusableView;
}
// 设置集合视图有多少个分区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.model.homeList.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MemberDetailGuanxiCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MemberDetailGuanxiCell" forIndexPath:indexPath];
    NSArray * arr =self.model.homeList[indexPath.section];
    [cell refreshCell:arr[indexPath.item]];
    return cell;
    
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}



-(void)refreshPostData
{
    
    NSDictionary * param =@{@"id":self.member.id};
    [RequestHelp POST:JS_MEMBER_DETAIL_URL parameters:param success:^(id result) {
        DLog(@"%@",result);
        self.model =[MemberDetailModel yy_modelWithJSON:result];
//        [self.dataAry addObjectsFromArray:[NSArray yy_modelArrayWithClass:[FamilyTreeModel class] json:result]];
     
        [self resolveData];
    } failure:^(NSError *error) {
    }];
}
-(void)resolveData
{
    NSMutableArray * ary =[NSMutableArray array];
    for (int i=0; i<self.model.homeList.count; i++)
    {
        NSArray * arr =[NSArray yy_modelArrayWithClass:[MemberDetailChild class] json:self.model.homeList[i]];
        [ary addObject:arr];
    }
    self.model.homeList =[NSArray arrayWithArray:ary];
    MKLog(@"%@",self.model);
    [self refreshUI];
}



-(void)refreshUI
{
    [self.memberImage sd_setImageWithURL:[NSURL URLWithString:self.model.headAddress] placeholderImage:KImageNamed(@"临时占位图")];
    self.memberName.text =self.model.name;
    if (self.model.homeList.count) {
        [self.tableView reloadData];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.坎坎坷坷乒乒乓乓乒乒乓乓乒乒乓乓乒乒乓乓乒乒乓乓乒乒乓乓乒乒乓乓乒乒乓乓乒乒乓乓乒乒乓乓乒乒乓乓婆婆哦 iiiiiiiiiiiiii 斤斤计较哈哈哈哈哈哈吧o
}
*/

@end
