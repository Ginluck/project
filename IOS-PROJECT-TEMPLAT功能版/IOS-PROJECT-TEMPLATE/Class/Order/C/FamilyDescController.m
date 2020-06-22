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

@property(nonatomic,weak)IBOutlet UIButton * lookBtn;
@end

@implementation FamilyDescController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUICompoents];
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

@end
