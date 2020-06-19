//
//  FamilyTreeController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/7.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "FamilyTreeController.h"
#import "FamilyTreeCell.h"
#import "FamilyLineController.h"
#import "SJActionSheet.h"
#import "FamilyMemberInfoController.h"
#import "AddNewMemberController.h"
#import "MemberDetailController.h"
#import "FamilyTreeModel.h"
#import "EMChatViewController.h"

@interface FamilyTreeController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,FamilyCellClickDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray  * dataAry ;
@property(nonatomic,assign)NSInteger  page;

@end

@implementation FamilyTreeController

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

    NSMutableArray * arr =[NSMutableArray arrayWithArray:@[@"查看成员信息"]];
    if ([self.model.isAdmin isEqualToString:@"1"] || [member.userUserId isEqualToString:user.id])
    {
        [arr addObject:@"编辑成员信息"];
        [arr addObject:@"添加下一代"];
    }

    if (!member.parentId.length)
    {
        if ([self.model.isAdmin isEqualToString:@"1"] || [member.userUserId isEqualToString:user.id])
        {
             [arr addObject:@"添加上一代"];
        }
    }
    if (member.userPhone.length && ![member.userPhone isEqualToString:user.userPhone])
    {
          [arr addObject:@"发起聊天"];
    }
    if ([member.isDelete isEqualToString:@"1"] && [self.model.isAdmin isEqualToString:@"1"])
    {
        [arr addObject:@"删除"];
    }
    if ([self.model.isAdmin isEqualToString:@"1"] && ![user.id isEqualToString:member.userUserId] && member.userPhone.length!=0)
    {
        [arr addObject:@"设置管理员"];
    }
    SJActionSheet *actionSheet = [[SJActionSheet alloc] initSheetWithTitle:nil style:SJSheetStyleDefault itemTitles:arr];
    actionSheet.itemTextFont =MKFont(13);
    actionSheet.cancelTextFont =MKFont(13);
    actionSheet.cancleTextColor=K_PROJECT_GARYTEXTCOLOR;
    actionSheet.itemTextColor =K_Prokect_MainColor;
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        if ([title isEqualToString:@"查看成员信息"]) {
            MemberDetailController * dc =[[MemberDetailController alloc]init];
            dc.member =member;
            [self.navigationController pushViewController:dc animated:YES];
        }
        if ([title isEqualToString:@"编辑成员信息"]) {
            AddNewMemberController * fvc =[[AddNewMemberController alloc]init];
            fvc.member =member;
            fvc.type =@"1";
            [self.navigationController pushViewController:fvc animated:YES];
        }
        if ([title isEqualToString:@"添加上一代"]) {
            AddNewMemberController * fvc =[[AddNewMemberController alloc]init];
            fvc.member =member;
            fvc.type =@"2";
            [self.navigationController pushViewController:fvc animated:YES];
        }
        if ([title isEqualToString:@"添加下一代"]) {
            AddNewMemberController * fvc =[[AddNewMemberController alloc]init];
            fvc.member =member;
            fvc.type =@"3";
            [self.navigationController pushViewController:fvc animated:YES];
        }
        if ([title isEqualToString:@"发起聊天"]) {
            EMChatViewController *chatController = [[EMChatViewController alloc] initWithConversationId:member.userPhone type:EMConversationTypeChat createIfNotExist:YES];
            chatController.userName =member.name;
            chatController.sendUrl =member.headAddress;
            chatController.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:chatController animated:YES];
        }
        if ([title isEqualToString:@"设置管理员"]) {
            NSDictionary * param =@{@"zpId":member.id,@"jzId":self.model.id,@"patriarch":@"1"};
            [RequestHelp POST:JS_SETADMIN_URL parameters:param success:^(id result) {
                MKLog(@"%@",result);
            } failure:^(NSError *error) {
                
            }];
        }
        if ([title isEqualToString:@"删除"]) {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                           message:@"确定要删除该成员吗."
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                      //响应事件
                                                                      NSDictionary * param =@{@"id":member.id,@"deleteStatus":@"2",@"jzId":member.jzId};
                                                                      [RequestHelp POST:JS_UPDATE_MEMBER_URL parameters:param success:^(id result) {
                                                                          ShowMessage(@"删除成功");
                                                                          [self postDate];
                                                                      } failure:^(NSError *error) {
                                                                          
                                                                      }];
                                                                      
                                                                      
                                                                  }];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * action) {
                                                                     //响应事件
                                                                   
                                                                 }];
            
            [alert addAction:defaultAction];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
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

        NSDictionary * param =@{@"jzId":self.model.id,@"spouseId":@"1",@"firstGeneration":@"1"};
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
