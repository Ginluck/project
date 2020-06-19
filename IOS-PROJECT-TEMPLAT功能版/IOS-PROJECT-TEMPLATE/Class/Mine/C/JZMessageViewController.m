//
//  JZMessageViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/29.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "JZMessageViewController.h"
#import "FamilyTreeCell.h"
#import "FamilyLineController.h"
#import "SJActionSheet.h"
#import "FamilyMemberInfoController.h"
#import "AddNewMemberController.h"
#import "MemberDetailController.h"
#import "FamilyTreeModel.h"
#import "EMChatViewController.h"
#import "AddNewMemberController.h"
@interface JZMessageViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,FamilyCellClickDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray  * dataAry ;
@property(nonatomic,assign)NSInteger  page;

@end

@implementation JZMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitleView:@"族谱"];
    [self.view addSubview:self.tableView];
    [self regisNib];
    [self postDate];
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
    UserModel *user =[[UserManager shareInstance]getUser];
    FamilyTreeModel *model =self.dataAry[button.row];
    FamilyTreeMember * member=(FamilyTreeMember*)model.list[button.tag];
    NSMutableArray * arr =[NSMutableArray arrayWithArray:@[@"查看成员信息",@"认祖确认"]];
    
    if (member.userPhone.length && ![member.userPhone isEqualToString:user.userPhone])
    {
          [arr addObject:@"发起聊天"];
    }
    if ([user.userName isEqualToString:member.name])
    {
          [arr addObject:@"确认自己"];
    }
  
    SJActionSheet *actionSheet = [[SJActionSheet alloc] initSheetWithTitle:nil style:SJSheetStyleDefault itemTitles:arr];
    actionSheet.itemTextFont =MKFont(13);
    actionSheet.cancelTextFont =MKFont(13);
    actionSheet.cancleTextColor=K_PROJECT_GARYTEXTCOLOR;
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        if ([title isEqualToString:@"查看成员信息"]) {
            MemberDetailController * dc =[[MemberDetailController alloc]init];
            dc.member =member;
            [self.navigationController pushViewController:dc animated:YES];
        }
       if ([title isEqualToString:@"认祖确认"]) {
           
           AddNewMemberController * fvc =[[AddNewMemberController alloc]init];
           fvc.member =member;
           fvc.type =@"4";
           [self.navigationController pushViewController:fvc animated:YES];

       }
        if ([title isEqualToString:@"确认自己"]) {
                            NSDictionary * param =@{@"jzId":member.jzId,@"userUserId":user.id,@"zpId":member.id,@"state":@"5"};
                                   [RequestHelp POST:JS_insert_URL parameters:param success:^(id result) {
                                       DLog(@"%@",result);
                                      ShowMessage(@"操作成功");
                                   } failure:^(NSError *error) {
                                   }];
               }
        if ([title isEqualToString:@"发起聊天"]) {
            EMChatViewController *chatController = [[EMChatViewController alloc] initWithConversationId:member.userPhone type:EMConversationTypeChat createIfNotExist:YES];
            chatController.userName =member.name;
            chatController.sendUrl =member.headAddress;
            chatController.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:chatController animated:YES];
        }
       
    }];
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

        NSDictionary * param =@{@"jzId":self.JzId,@"spouseId":@"1",@"firstGeneration":@"1"};
        [RequestHelp POST:JS_SELECT_ZPLIST_URL parameters:param success:^(id result) {
            DLog(@"%@",result);
            [self.dataAry addObjectsFromArray:[NSArray yy_modelArrayWithClass:[FamilyTreeModel class] json:result]];
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
