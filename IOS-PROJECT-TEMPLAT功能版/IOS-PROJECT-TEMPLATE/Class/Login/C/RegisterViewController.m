//
//  RegisterViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/7.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "RegisterViewController.h"
#import "UILabel+WY_RichText.h"
#import "NSMutableParagraphStyle+WY_Extension.h"
#import "NSMutableAttributedString+WY_Extension.h"
#import "NSString+Encryption.h"
#import "JKCountDownButton.h"
#import "PolicyViewController.h"
@interface RegisterViewController ()
@property(nonatomic,strong)NSString *userAgreement;
@property(nonatomic,strong)NSString *aboutAgreement;
@property(nonatomic,strong)NSString *ImgStr;
@end

@implementation RegisterViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self hideNavigationBar:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.editing=NO;
    [self hideNavigationBar:NO animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self postdata];
    [self.NumberTF addTarget:self action:@selector(phoneNumberTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.PwdTF  addTarget:self action:@selector(passwordTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.YQMTF  addTarget:self action:@selector(yqmTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.NavHeight.constant =kNavagationBarH;
       [self.NavView setNeedsLayout];
     //需要点击的字符不同
        NSString *label_text2 = @"同意《协议》";
        NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc]initWithString:label_text2];
        [attributedString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(2, 4)];
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor darkTextColor] range:NSMakeRange(2, 4)];
        
        self.xieyiLab.attributedText = attributedString2;
    
//       self.xieyiLab.wy_enabledClickEffect = NO;
    [self.xieyiLab addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap:)]];

    //    WS(weakSelf);
    self.xieyiLab.userInteractionEnabled = YES;
//        [self.xieyiLab wy_clickRichTextWithStrings:@[@"《协议》"] clickAction:^(NSString *string, NSRange range, NSInteger index) {
//            NSString *message = [NSString stringWithFormat:@"点击了“%@”字符\nrange: %@\nindex: %ld",string,NSStringFromRange(range),(long)index];
//            NSLog(@"messge = %@",message);
//           PolicyViewController *PVC =[PolicyViewController new];
//            PVC.UrlStr = self.userAgreement;
//            [PVC addNavigationTitleView:@"用户协议"];;
//[self.navigationController pushViewController:PVC animated:YES];
    
//        }];
        //设置是否有点击效果，默认是YES
    [RequestHelp POST:getImgCode_url parameters:@{} success:^(id result) {
          [self.CodeBtn setBackgroundImage:[self stringToImage:result[@"data"]] forState:UIControlStateNormal ];
        self.ImgStr=result[@"imgCodeKey"];
      } failure:^(NSError *error) {

      }];
    // Do any additional setup after loading the view from its nib.
}

-(void)labelTap:(UIGestureRecognizer*)guesture
{
//    NSString *message = [NSString stringWithFormat:@"点击了“%@”字符\nrange: %@\nindex: %ld",string,NSStringFromRange(range),(long)index];
//    NSLog(@"messge = %@",message);
    PolicyViewController *PVC =[PolicyViewController new];
    PVC.UrlStr = self.userAgreement;
    [PVC addNavigationTitleView:@"用户协议"];;
    [self.navigationController pushViewController:PVC animated:YES];
}
-(void)postdata
{
       [RequestHelp POST:selectByAll_URL parameters:@{} success:^(id result) {
           DLog(@"%@",result);
           self.userAgreement=result[@"userAgreement"];
           self.aboutAgreement=result[@"aboutAgreement"];
       } failure:^(NSError *error) {
           
       }];
}
- (void)phoneNumberTextFieldDidChange:(UITextField *)textField{
    if (textField.text.length > 11) {
       textField.text=[textField.text  substringToIndex:11];
    }
}
- (void)yqmTextFieldDidChange:(UITextField *)textField{
    if (textField.text.length > 10) {
       textField.text=[textField.text  substringToIndex:10];
    }
}
- (void)passwordTextFieldDidChange:(UITextField *)textField{
    NSString *str;
    if (textField.text.length > 16) {
        ShowMessage(@"密码不能超过16位");
       textField.text=str;
    }
    else
    {
        str=textField.text;
    }
}
-(void)setNumberView:(UIView *)NumberView
{
     NumberView.layer.masksToBounds=YES;
       
       NumberView.layer.shadowColor =COLOR(225, 225, 225, 1).CGColor;
       
       NumberView.layer.shadowOffset = CGSizeMake(1, 1);
       
       NumberView.layer.shadowOpacity = 1;
       
       NumberView.layer.shadowRadius = 3.0;
       
       NumberView.layer.cornerRadius = 30.0*Kscale;
       
       NumberView.clipsToBounds = NO;
}
-(void)setPwdView:(UIView *)PwdView
{
     PwdView.layer.masksToBounds=YES;
       
       PwdView.layer.shadowColor =COLOR(225, 225, 225, 1).CGColor;
       
       PwdView.layer.shadowOffset = CGSizeMake(1, 1);
       
       PwdView.layer.shadowOpacity = 1;
       
       PwdView.layer.shadowRadius = 3.0;
       
       PwdView.layer.cornerRadius = 30.0*Kscale;
       
       PwdView.clipsToBounds = NO;
}
-(void)setCodeView:(UIView *)CodeView
{
     CodeView.layer.masksToBounds=YES;
       
       CodeView.layer.shadowColor =COLOR(225, 225, 225, 1).CGColor;
       
       CodeView.layer.shadowOffset = CGSizeMake(1, 1);
       
       CodeView.layer.shadowOpacity = 1;
       
       CodeView.layer.shadowRadius = 3.0;
       
       CodeView.layer.cornerRadius = 30.0*Kscale;
       
       CodeView.clipsToBounds = NO;
}
-(void)setYQMView:(UIView *)YQMView

    {
         YQMView.layer.masksToBounds=YES;
           
           YQMView.layer.shadowColor =COLOR(225, 225, 225, 1).CGColor;
           
           YQMView.layer.shadowOffset = CGSizeMake(1, 1);
           
           YQMView.layer.shadowOpacity = 1;
           
           YQMView.layer.shadowRadius = 3.0;
           
           YQMView.layer.cornerRadius = 30.0*Kscale;
           
           YQMView.clipsToBounds = NO;
    }
-(void)setLoginBtn:(UIButton *)LoginBtn
{
          LoginBtn.layer.masksToBounds=YES;
          
       
          
          LoginBtn.layer.cornerRadius = 30.0*Kscale;
          
         
}
- (IBAction)XieYiBtn:(UIButton *)sender {
    if (sender.selected) {
      
        [sender setTitle:@"" forState:UIControlStateNormal];
        sender.backgroundColor=[UIColor whiteColor];
    }else
    {
        [sender setTitle:@"✓" forState:UIControlStateNormal];
        sender.backgroundColor=K_Prokect_MainColor;
    }
    sender.selected =!sender.selected;
}
- (IBAction)registerClick:(id)sender {
    DLog(@"%@",[UIUtils getCurrentTimes]);
    if (![UIUtils isValidateMobile:self.NumberTF.text]) {
        ShowMessage(@"请输入正确的手机号");
        return;
    }
    if (!self.PwdTF.text.length) {
        ShowMessage(@"请输入密码");
        return;
    }
    if (!self.CodeTF.text.length) {
        ShowMessage(@"请输入验证码");
        return;
    }
   if (self.PwdTF.text.length<8) {
              ShowMessage(@"密码不能少于8位");
             return;
         }
    if (!self.XieYiBtn.selected) {
        ShowMessage(@"请勾选协议");
        return;
    }
    NSDictionary * param  =@{@"userPhone":self.NumberTF.text,@"password":[self.PwdTF.text encryptAESWithkey:[UIUtils getCurrentTimes]],@"validCode":self.CodeTF.text,@"imgCodeKey":self.ImgStr};
    [RequestHelp POST:@"userApp/register" parameters:param success:^(id result) {
        DLog(@"%@",result);
        ShowMessage(@"注册成功");
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)GetCodeClick:(JKCountDownButton *)sender {
    [RequestHelp POST:getImgCode_url parameters:@{} success:^(id result) {
        [self.CodeBtn setBackgroundImage:[self stringToImage:result[@"data"]] forState:UIControlStateNormal ];
      self.ImgStr=result[@"imgCodeKey"];
    } failure:^(NSError *error) {

    }];
//    if (![UIUtils isValidateMobile:self.NumberTF.text]) {
//        ShowMessage(@"请输入正确的手机号");
//        return;
//    }
//    WS(weakSelf);
//    NSDictionary *dicParams = @{@"userPhone":self.NumberTF.text,@"codeType":@"12"};
    //    [RequestHelp POST:GETSECURITYCODE_url parameters:dicParams success:^(id result) {
    //        weakSelf.CodeBtn.enabled = NO;
    //        [weakSelf.CodeBtn startWithSecond:60];
    //        [weakSelf.CodeBtn didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
    //            NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
    //            return title;
    //        }];
    //        [weakSelf.CodeBtn didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
    //            countDownButton.enabled = YES;
    //            return @"获取验证码";
    //        }];
    //    } failure:^(NSError *error) {
    //
    //    }];
    
}
- (UIImage *)stringToImage:(NSString *)str

{

    NSData * imageData =[[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];

    UIImage *photo = [UIImage imageWithData:imageData ];

    return photo;

}
- (IBAction)HideClick:(UIButton *)sender {
    if ([sender.currentBackgroundImage isEqual:[UIImage imageNamed:@"eye_close"]] ) {
        [sender setBackgroundImage:[UIImage imageNamed:@"eye_open"] forState:UIControlStateNormal];
        self.PwdTF.secureTextEntry=NO;
    }else
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"eye_close"] forState:UIControlStateNormal];
         self.PwdTF.secureTextEntry=YES;
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
