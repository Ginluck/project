//
//  FamilyDescController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/22.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "FamilyDescController.h"
#import "ApplyController.h"
@interface FamilyDescController ()
@property(nonatomic,weak)IBOutlet UIButton * addrBtn;
@property(nonatomic,weak)IBOutlet UITextField * nameTF;
@property(nonatomic,weak)IBOutlet UIButton * detailAddr;
@property(nonatomic,weak)IBOutlet UITextView * contentTV;
@property(nonatomic,strong)NSMutableArray  * dataAry ;
@property(nonatomic,weak)IBOutlet UIButton * lookBtn;
@end

@implementation FamilyDescController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self requestData];
  
}
-(NSMutableArray *)dataAry
{
    if (!_dataAry) {
        _dataAry =[NSMutableArray array];
    }
    return _dataAry;
}
-(void)setUICompoents
{
    self.lookBtn.hidden=NO;
    self.nameTF.text =self.model.name;
    [self.addrBtn setTitle:self.model.pcaName forState:UIControlStateNormal];
    [self.detailAddr setTitle:self.model.address forState:UIControlStateNormal];
    self.contentTV.text =self.model.introduce;
}
-(IBAction)jumpClick
{
    if ([self.model.countType integerValue]!=0)
    {
        ShowMessage(@"您不能申请自己创建的家族");
        return;
    }
    if ([self.model.userType integerValue]!=0)
    {
        ShowMessage(@"您已申请该家族，请勿重新申请");
        return;
    }
    if ([self.model.zpJzType integerValue] !=0) {
        ShowMessage(@"您已加入该家族");
    }
    
    ApplyController * AVC =[ApplyController new];
    AVC.model =self.model;
    [self.navigationController pushViewController:AVC animated:YES];
}



-(void)requestData
{
    UserModel * model =[[UserManager shareInstance]getUser];
    [RequestHelp POST:JS_FAMILY_LIST_URL2 parameters:@{@"pageNum":@"1",@"pageRow":@"1",@"id":self.model.id,@"userUserId":model.id} success:^(id result) {
        MKLog(@"%@",result);
        [self.dataAry addObjectsFromArray:[NSArray yy_modelArrayWithClass:[FamilyListModel class] json:result[@"list"]]];
        
        if (self.dataAry.count)
        {
            self.model =self.dataAry[0];
            [self setUICompoents];
        }
     
    } failure:^(NSError *error) {
        
    }];
}

@end
