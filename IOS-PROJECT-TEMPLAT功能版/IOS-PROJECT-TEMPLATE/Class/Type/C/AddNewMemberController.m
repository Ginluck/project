//
//  AddNewMemberController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/9.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "AddNewMemberController.h"
#import "UITextView+WJPlaceholder.h"
#import "ValuePickerView.h"
#import "LYSDatePickerController.h"
#import "FamilyDetailController.h"
#import "NSDate+CommonDate.h"
@interface AddNewMemberController ()<LYSDatePickerSelectDelegate>
@property(nonatomic,weak)IBOutlet UITextField * nameTF;
@property(nonatomic,weak)IBOutlet UIButton * sexBtn;
@property(nonatomic,strong) NSString * sexValue;
@property(nonatomic,weak)IBOutlet UIButton * stateBtn;
@property(nonatomic,strong) NSString * stateValue;
@property(nonatomic,weak)IBOutlet UIButton * birthBtn;
@property(nonatomic,strong) NSString * birth;
@property(nonatomic,strong) NSDate * birthDate;
@property(nonatomic,weak)IBOutlet UIButton * deathBtn;
@property(nonatomic,strong) NSString * death;
@property(nonatomic,strong) NSDate * deathDate;
@property(nonatomic,weak)IBOutlet UITextView * indtroduceTV;
@property(nonatomic,strong)ValuePickerView *pickerView ;
@property(nonatomic,strong) NSDate *currentDate;
@property(nonatomic,strong)UIImageView *backImage;
@end

@implementation AddNewMemberController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavigationTitleView:@"添加成员"];
//      [self.view addSubview:self.backImage];
    [self setUICompoents];
}
-(UIImageView *)backImage
{
    if (!_backImage) {
        _backImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        _backImage.image =KImageNamed(@"通用背景");
    }
    return _backImage;
}
-(ValuePickerView*)pickerView
{
    if (!_pickerView) {
        _pickerView =[ValuePickerView new];
    }
    return _pickerView;
}
-(void)setUICompoents
{
    self.indtroduceTV.placeholdFont =MKFont(13);
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
    NSDate  * date =[NSDate date];
    _currentDate =date;
    self.stateBtn.userInteractionEnabled =YES;
    if ([self.type  isEqualToString:@"1"]) {
        self.nameTF.text =self.member.name;
        [self.sexBtn setTitle:[self.member.sex isEqualToString:@"0"]?@"男":@"女" forState:UIControlStateNormal];
        self.sexValue =self.member.sex;
        if (self.member.deathTime.length)
        {
            self.stateBtn.userInteractionEnabled =NO;
          
        }
        [self.stateBtn setTitle:[self.member.state isEqualToString:@"0"]?@"在世":@"离世" forState:UIControlStateNormal];
        self.stateValue =self.member.state;
       
        self.birth =[self.member.birthTime substringToIndex:10];
        [self.birthBtn setTitle:self.birth forState:UIControlStateNormal];
        self.birthDate =[NSDate dateWithFormat:@"yyyy-MM-dd" dateString:self.birth];
        
        self.death =[self.member.deathTime substringToIndex:10];
        [self.deathBtn setTitle:self.death forState:UIControlStateNormal];
        self.deathDate =[NSDate dateWithFormat:@"yyyy-MM-dd" dateString:self.death];
        
        self.indtroduceTV.placeholder =@"";
        [self addNavigationTitleView:@"修改成员"];
        self.indtroduceTV.text =self.member.introduce;
    }
  
}


-(IBAction)btnClick:(UIButton*)sender
{
    [self.nameTF endEditing:YES];
    switch (sender.tag) {
        case 10:
        {
            WS(weakSelf);
            self.pickerView.pickerTitle =@"选择性别";
            self.pickerView.dataSource=@[@"男",@"女"];
            [self.pickerView show];
            self.pickerView.valueDidSelect = ^(NSString *value){
                [weakSelf.sexBtn setTitle:value forState:UIControlStateNormal];
                weakSelf.sexValue =[NSString stringWithFormat:@"%lu",(unsigned long)[weakSelf.pickerView.dataSource indexOfObject:value]];
            };
        }
            break;
        case 11:
        {
               WS(weakSelf);
            self.pickerView.pickerTitle =@"选择在世状态";
            self.pickerView.dataSource=@[@"在世",@"离世"];
            [self.pickerView show];
            self.pickerView.valueDidSelect = ^(NSString *value){
                [weakSelf.stateBtn setTitle:value forState:UIControlStateNormal];
                weakSelf.stateValue =[NSString stringWithFormat:@"%lu",(unsigned long)[weakSelf.pickerView.dataSource indexOfObject:value]];
            };
        }
            break;
        case 12:
        {
            WS(weakSelf);
            [LYSDatePickerController alertDatePickerInWindowRootVCWithType:(LYSDatePickerTypeDay) selectDate:_currentDate];
           
            [LYSDatePickerController customPickerDelegate:self];
            [LYSDatePickerController customdidSelectDatePicker:^(NSDate *date) {
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-MM-dd"];
                self.birthDate =date;
                weakSelf.currentDate = date;
                if (self.deathDate !=nil)
                {
                    if ([self.deathDate compare:self.birthDate]==-1)
                    {
                        ShowMessage(@"请选择正确的出生日期");
                        return ;
                    }
                }
                if ([[NSDate date] compare:date]==-1)
                {
                    ShowMessage(@"请选择正确的出生日期");
                    return ;
                }
                [sender setTitle:[NSString stringWithFormat:@"%@",[dateFormat stringFromDate:date]] forState:UIControlStateNormal];
                weakSelf.birth =[dateFormat stringFromDate:date];
            }];
        }
            break;
        case 13:
        {
            WS(weakSelf);
            [LYSDatePickerController alertDatePickerInWindowRootVCWithType:(LYSDatePickerTypeDay) selectDate:_currentDate];
            [LYSDatePickerController customPickerDelegate:self];
            [LYSDatePickerController customdidSelectDatePicker:^(NSDate *date) {
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-MM-dd"];
                self.deathDate =date;
                if (self.birthDate !=nil)
                {
                    if ([self.deathDate compare:self.birthDate]==-1)
                    {
                        ShowMessage(@"请选择正确的离世日期");
                        return ;
                    }
                }
                
                if ([[NSDate date] compare:date]==-1) {
                    ShowMessage(@"请选择正确的离世日期");
                    return ;
                }
                weakSelf.currentDate = date;
                [sender setTitle:[NSString stringWithFormat:@"%@",[dateFormat stringFromDate:date]] forState:UIControlStateNormal];
                weakSelf.death =[dateFormat stringFromDate:date];
            }];
        }
            break;
            
        default:
            break;
    }
}



-(IBAction)commitClick:(id)sender
{
    NSMutableDictionary * param =[NSMutableDictionary dictionary];
    if (!self.nameTF.text.length)
    {
        ShowMessage(@"请输入姓名");return;
    }
    else
    {
        [param setValue:self.nameTF.text forKey:@"name"];
    }
    if (!self.sexValue.length)
    {
         ShowMessage(@"请选择性别");return;
    }
    else
    {
        [param setValue:self.sexValue forKey:@"sex"];
    }
    if (!self.stateValue.length)
    {
        ShowMessage(@"请选择在世状态");return;
    }
    else
    {
        [param setValue:self.stateValue forKey:@"state"];
    }
    if (!self.birth.length)
    {
        ShowMessage(@"请选择出生日期");return;
    }
    else
    {
        [param setValue:self.birth forKey:@"birthTime"];
    }
    if (!self.indtroduceTV.text.length)
    {
        ShowMessage(@"请输入个人简介");return;
    }
    else
    {
        [param setValue:self.indtroduceTV.text forKey:@"introduce"];
    }
    if ([self.stateValue isEqualToString:@"1"])
    {
        if (!self.death.length)
        {
            ShowMessage(@"请选择离世日期");return;
        }
        else
        {
            [param setValue:self.death forKey:@"deathTime"];
        }

    }
   
    if ([self.type isEqualToString:@"1"])
    {
        [param setValue:self.member.id forKey:@"id"];
        [param setValue:self.member.jzId forKey:@"jzId"];
        [RequestHelp POST:JS_UPDATE_MEMBER_URL parameters:param success:^(id result) {
            MKLog(@"%@",result);
            ShowMessage(@"操作成功");
            for (UIViewController * fvc in self.navigationController.viewControllers) {
                if ([fvc isKindOfClass:[FamilyDetailController class]]) {
                       [self.navigationController popToViewController:fvc animated:YES];
                }
            }
       
        } failure:^(NSError *error) {}];
    }
    else if ([self.type isEqualToString:@"2"])
    {
        [param setValue:@"0" forKey:@"type"];
        [param setValue:self.member.id forKey:@"coverId"];
        [param setValue:self.member.jzId forKey:@"jzId"];
        [RequestHelp POST:JS_ADD_NEWMEMBER_URL parameters:param success:^(id result) {
            MKLog(@"%@",result);
            ShowMessage(@"操作成功");
            for (UIViewController * fvc in self.navigationController.viewControllers) {
                if ([fvc isKindOfClass:[FamilyDetailController class]]) {
                    [self.navigationController popToViewController:fvc animated:YES];
                }
            }
        } failure:^(NSError *error) {}];
    }
    else if ([self.type isEqualToString:@"3"])
    {
        [param setValue:@"1" forKey:@"type"];
        [param setValue:self.member.id forKey:@"coverId"];
        [param setValue:self.member.jzId forKey:@"jzId"];
        [RequestHelp POST:JS_ADD_NEWMEMBER_URL parameters:param success:^(id result) {
            MKLog(@"%@",result);
            ShowMessage(@"操作成功");
            for (UIViewController * fvc in self.navigationController.viewControllers) {
                if ([fvc isKindOfClass:[FamilyDetailController class]]) {
                    [self.navigationController popToViewController:fvc animated:YES];
                }
            }
        } failure:^(NSError *error) {}];
    }
    else if ([self.type isEqualToString:@"4"])
    {
         UserModel *user =[[UserManager shareInstance]getUser];
        [param setValue:@"2" forKey:@"type"];
        [param setValue:self.member.id forKey:@"coverId"];
        [param setValue:self.member.jzId forKey:@"jzId"];
        [param setValue:user.id forKey:@"userUserId"];
        [RequestHelp POST:JS_ADD_NEWMEMBER_URL parameters:param success:^(id result) {
            MKLog(@"%@",result);
            ShowMessage(@"操作成功");
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        } failure:^(NSError *error) {}];
    }
    

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
