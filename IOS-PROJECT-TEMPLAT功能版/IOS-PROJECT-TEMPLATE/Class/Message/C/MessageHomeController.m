//
//  MessageHomeController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2019/12/10.
//  Copyright © 2019年 梦境网络. All rights reserved.
//

#import "MessageHomeController.h"
#import "MessageListTableViewCell.h"
//#import "EMChatViewController.h"
//#import "MessageModelList.h"
#import "SystemMessageController.h"
//#import "HouseMessageViewController.h"
#import "EMChatViewController.h"
@interface MessageHomeController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * dataArr;
@property(nonatomic,strong)NSArray * dataAry;
@property(nonatomic,strong)NSArray * dataSource;

@end

@implementation MessageHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitleView:@"消息"];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    self.tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
    // Do any additional setup after loading the view.
}
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, K_NaviHeight, Screen_Width, Screen_Height-kNavagationBarH ) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        UIImageView * imageV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, CGRectGetHeight(_tableView.frame))];
        imageV.image =KImageNamed(@"通用背景");
        _tableView.backgroundView =imageV;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = [UIColor clearColor];
        if (@available(iOS 11, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MessageListTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MessageListTableViewCell class])];
        
    }
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0)
    {
        return 1;
    }
    return  self.dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section ==0)
    {
        MessageListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MessageListTableViewCell class]) forIndexPath:indexPath];
        cell.backgroundView .backgroundColor =[UIColor clearColor];
        cell.backgroundColor =[UIColor clearColor];
        cell.selectionStyle  =UITableViewCellSeparatorStyleNone;
        cell.timeLabel.text =@"";
        cell.isRead.hidden=YES;
        switch (indexPath.row) {
            case 0:
            {
                cell.nameLabel.text =@"系统消息";
                cell.messageLabel.text =@"您有新的系统消息";
                cell.headerImage.image =KImageNamed(@"系统消息");
            }
                break;
            default:
                break;
        }
        return cell;
    }
    else
    {
        MessageListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MessageListTableViewCell class]) forIndexPath:indexPath];
        cell.backgroundView .backgroundColor =[UIColor clearColor];
        cell.backgroundColor =[UIColor clearColor];
        cell.selectionStyle  =UITableViewCellSeparatorStyleNone;
        [cell refreshMessage:self.dataSource[indexPath.row]];
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        UserModel* model=self.dataSource[indexPath.row];
        model.isRead =@"1";
        NSMutableArray * ary =[NSMutableArray arrayWithArray:self.dataSource];
        [ary replaceObjectAtIndex:indexPath.row withObject:model];
        self.dataSource =[NSArray arrayWithArray:ary];
        EMChatViewController *chatController = [[EMChatViewController alloc] initWithConversationId:model.userPhone type:EMConversationTypeChat createIfNotExist:YES];
        chatController.userName =model.realName;
        chatController.sendUrl =model.headAddress;
        chatController.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:chatController animated:YES];
    }
    else
    {
        if (indexPath.row==0) {
            SystemMessageController * svc =[SystemMessageController new];
            svc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:svc animated:YES];
//            EMChatViewController *chatController = [[EMChatViewController alloc] initWithConversationId:@"13273436004" type:EMConversationTypeChat createIfNotExist:YES];
////                        chatController.userName =model.userName;
////                        chatController.sendUrl =model.headAddress;
//                        chatController.hidesBottomBarWhenPushed=YES;
//                        [self.navigationController pushViewController:chatController animated:YES];
        }
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UserModel  * model =[[UserManager shareInstance]getUser];
    EMError *error = [[EMClient sharedClient] loginWithUsername:model.userPhone password:model.password];
    if (!error) {
        DLog(@"登录成功");
    }
     self.dataArr =[[EMClient sharedClient].chatManager getAllConversations];
    if (self.dataAry.count)
    {
        if (!self.dataArr.count) {
            return;
        }
        [self requestData];
    }
    else
    {
        if (!self.dataArr.count) {
            return;
        }
        [self requestData];
    }
//
    [self hideNavigationBar:NO animated:NO];
}

-(void)requestData
{
    NSMutableArray* ary =[NSMutableArray array];
    for (EMConversation * conversation in self.dataArr)
    {
        [ary addObject:conversation.conversationId];
    }

    NSString * phoneArray= [ary componentsJoinedByString:@","];
    [RequestHelp POST:JS_GETCONVERSATION_URL parameters:@{@"PhoneArray":phoneArray} success:^(id result) {
        self.dataAry =[NSArray yy_modelArrayWithClass:[UserModel class] json:result];
        [self createDataSource];
    } failure:^(NSError *error) {

    }];
}

-(void)createDataSource
{
    NSMutableArray * array =[NSMutableArray array];
    for (EMConversation * con in self.dataArr)
    {
        for (UserModel * model in self.dataAry)
        {
            if ([model.userPhone isEqualToString:con.conversationId])
            {
                model.messageTime =[UIUtils getHXtimeStr:con.latestMessage.localTime];
                model.lastMessage =[self textFromMessage:con.latestMessage];
                [array addObject:model];
            }
        }
    }
    self.dataSource =[NSArray arrayWithArray:array];
    [self.tableView reloadData];
}
-(NSString *)textFromMessage:(EMMessage *)message
{
    EMMessageBody *body = message.body;
    if (body.type !=1) {
        return @"";
    }

    EMTextMessageBody *textBody = (EMTextMessageBody *)body;

    NSString *text = textBody.text;
    return text;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

@end
