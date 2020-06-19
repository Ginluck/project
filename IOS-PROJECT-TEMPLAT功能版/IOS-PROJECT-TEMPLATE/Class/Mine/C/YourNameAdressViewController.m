//
//  YourNameAdressViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/29.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "YourNameAdressViewController.h"
#import "MyIntroductionViewController.h"
#import "SheZhiNameViewController.h"
#import "AddrChooseController.h"
#import "MineDataModel.h"
#import "UserTextView.h"
#import "FirstTypeHomeViewController.h"
#import "SJActionSheet.h"
@interface YourNameAdressViewController ()
<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UIImagePickerController *imagePickerVC;
@property(nonatomic,strong)UIView *BackGroundView;
@property(nonatomic,strong)NSString *HeadImgStr;
@property (strong, nonatomic)  UserTextView *TxtView;
@end

@implementation YourNameAdressViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.KNavHeight.constant=kNavagationBarH;
    [self.KNavView setNeedsLayout];
    [self AllocTextView];
    self.AddressLab.userInteractionEnabled=YES;
    [self addNavigationTitleView:@"个人资料"];
    [self requsetData];
    // Do any additional setup after loading the view from its nib.
}
-(void)AllocTextView
{
     _TxtView =[[UserTextView alloc]initWithFrame:CGRectMake(16, 290, Screen_Width-32, 200)];
    self.TxtView.placeholder=@"写点什么吧...";
    self.TxtView.placeholderColor=[UIColor lightGrayColor];
    [self.BgView addSubview:self.TxtView];
}
-(UIImagePickerController *)imagePickerVC
{
    if (!_imagePickerVC)
    {
        _imagePickerVC =[UIImagePickerController new];
        _imagePickerVC.delegate =self;
        _imagePickerVC.allowsEditing=YES;
    }
    return _imagePickerVC;
}
-(void)requsetData
{
    UserModel * model =[[UserManager shareInstance]getUser];
       NSDictionary* param_dic =@{@"userPhone":model.userPhone};
       [RequestHelp POST:SELECT_USERINFO_url parameters:param_dic success:^(id result) {
           MKLog(@"%@",result);
         MineDataModel *model =[MineDataModel yy_modelWithJSON:result];
            [self.HeadImg sd_setImageWithURL:[NSURL URLWithString:model.headAddress] placeholderImage:[UIImage imageNamed:@"临时占位图"]];
            self.NumberLab.text=model.userPhone;
            self.Namelab.text=model.realName;
            self.AddressLab.text=model.address;
           self.HeadImgStr=model.headAddress;
           if (model.realName ==nil ||model.realName ==NULL||model.realName.length==0 ) {
               self.Namelab.text=@"";
               self.Namelab.placeholder=@"请输入姓名";
           }
           if (model.address ==nil ||model.address ==NULL||model.address.length==0 ) {
               self.AddressLab.text=@"请选择地址";
             
           }
       } failure:^(NSError *error) {
           
       }];
}
- (IBAction)Click:(UIButton *)sender {    
    switch (sender.tag) {
        case 100:
        {
            SJActionSheet *actionSheet = [[SJActionSheet alloc] initSheetWithTitle:@"选择图片" style:SJSheetStyleDefault itemTitles:@[@"相机",@"相册"]];
            actionSheet.titleTextFont =MKFont(15);
            actionSheet.itemTextFont =MKFont(13);
            actionSheet.cancelTextFont =MKFont(13);
            actionSheet.itemTextColor =K_Prokect_MainColor;
            actionSheet.cancleTextColor=K_PROJECT_GARYTEXTCOLOR;
            [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
                if ([title isEqualToString:@"相机"])
                {
                    [self selectImageFromCamera];
                }
                else if ([title isEqualToString:@"相册"])
                {
                    [self selectImageFromAlbum];
                }
            }];
              
        }
            break;
            case 101:
            {
               
            }
                break;
            case 102:
            {
                AddrChooseController * avc =[AddrChooseController new];
                avc.selectedRoomBlock = ^(NSObject * _Nonnull model) {
                    if ([model isKindOfClass:[QMSReGeoCodePoi class]])
                    {
                        QMSReGeoCodePoi * code =(QMSReGeoCodePoi*)model;
                       self.AddressLab.text=code.title;
//                        self.addr =code.title;
//                        self.lon =[NSString stringWithFormat:@"%f",code.location.longitude];
//                        self.lat =[NSString stringWithFormat:@"%f",code.location.latitude];
                    }
                    else if ([model isKindOfClass:[QMSSuggestionPoiData class]])
                    {
                        QMSSuggestionPoiData * code =(QMSSuggestionPoiData*)model;
//                        self.addr =code.title;
//                        [self.detailAddr setTitle:code.title forState:UIControlStateNormal];
//                        self.lon =[NSString stringWithFormat:@"%f",code.location.longitude];
//                        self.lat =[NSString stringWithFormat:@"%f",code.location.latitude];
                        self.AddressLab.text=code.title;
                    }
                    self.AddressLab.text=@"河北省石家庄市长安区裕华东路123号";
                  
                };
                [self.navigationController pushViewController:avc animated:YES];
            }
                break;
           
            
        default:
            break;
    }
}
#pragma mark 拍摄
-(void)selectImageFromCamera{
    //2
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // 设置资源来源
        self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        // 设置可用的媒体类型、默认只包含kUTTypeImage，如果想选择视频，请添加kUTTypeMovie
        self.imagePickerVC.mediaTypes = @[(NSString *)kUTTypeMovie, (NSString *)kUTTypeImage];
        
        // 如果选择的是视屏，允许的视屏时长为20秒
        self.imagePickerVC.videoMaximumDuration = 20;
        // 允许的视屏质量（如果质量选取的质量过高，会自动降低质量）
        self.imagePickerVC.videoQuality = UIImagePickerControllerQualityTypeHigh;
        // 相机获取媒体的类型（照相、录制视屏）
        self.imagePickerVC.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        // 使用前置还是后置摄像头
        self.imagePickerVC.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        // 是否看起闪光灯
        self.imagePickerVC.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
        // 设置是否显示系统的相机页面
        self.imagePickerVC.showsCameraControls = YES;
        // model出控制器
        self.imagePickerVC.modalPresentationStyle=UIModalPresentationFullScreen;
        [self presentViewController:self.imagePickerVC animated:YES completion:nil];
    }
}
- (void)selectImageFromAlbum{
    //6
    // 判断当前的sourceType是否可用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        // 设置资源来源（相册、相机、图库之一）
        self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 设置可用的媒体类型、默认只包含kUTTypeImage，如果想选择视频，请添加kUTTypeMovie
        // 如果选择的是视屏，允许的视屏时长为20秒
        self.imagePickerVC.videoMaximumDuration = 20;
        // 允许的视屏质量（如果质量选取的质量过高，会自动降低质量）
        self.imagePickerVC.videoQuality = UIImagePickerControllerQualityTypeHigh;
        self.imagePickerVC.mediaTypes = @[(NSString *)kUTTypeMovie, (NSString *)kUTTypeImage];
        // model出控制器
        self.imagePickerVC.modalPresentationStyle=UIModalPresentationFullScreen;
        [self presentViewController:self.imagePickerVC animated:YES completion:nil];
    }
}
// 选择图片成功调用此方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //3
    [self dismissViewControllerAnimated:YES completion:nil];
    //如果是拍照
    UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
    /***
     */
    [self uploadImage:image];
    if(picker.sourceType==UIImagePickerControllerSourceTypePhotoLibrary){
        
    }else{
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image: didFinishSavingWithError: contextInfo:), nil);
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}
//保存图片到本地相册
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    //4
    if (error == nil) {
        NSLog(@"成功");
    }
    else{
        NSLog(@"失败");
    }
}

// 取消图片选择调用此方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    //5
    // dismiss UIImagePickerController
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)uploadImage:(UIImage * )image
{
    ShowMaskStatus(@"正在上传");
    NSData * data =UIImagePNGRepresentation(image);
    [RequestHelp uploadPhotoData:data success:^(id result) {
        DLog(@"%@",result);
        DismissHud();
        self.HeadImgStr=result[@"url"];
         self.HeadImg.image=image;
    } failure:^(NSError *error) {
        DismissHud();
    }];
}
- (IBAction)SaveClick:(id)sender {
     UserModel * model =[[UserManager shareInstance]getUser];
    if (self.Namelab.text.length==0) {
        ShowMessage(@"请填写姓名");
        return;
    }
    if (self.AddressLab.text.length==0||[self.AddressLab.text isEqualToString:@"请选择地址"]) {
           ShowMessage(@"请选择地址");
           return;
       }
    NSDictionary* param_dic =@{@"userPhone":model.userPhone,@"realName":self.Namelab.text,@"address":self.AddressLab.text,@"headAddress":self.HeadImgStr,@"introduce":self.TxtView.text};
          [RequestHelp POST:UPDATE_ZJ_url parameters:param_dic success:^(id result) {
              MKLog(@"%@",result);
              ShowMessage(@"提交成功");
              model.realName=self.Namelab.text;
              model.address=self.AddressLab.text;
              model.headAddress=self.HeadImgStr;
              model.introduce=self.TxtView.text;
              [[UserManager shareInstance]saveUser:model];
              FirstTypeHomeViewController *FTHVC=[FirstTypeHomeViewController new];
              FTHVC.VCClick = ^(NSInteger index) {
                  [ViewControllerManager showMainViewController];
                [self.navigationController dismissViewControllerAnimated:NO completion:nil];
              };
              [self.navigationController pushViewController:FTHVC animated:YES];
             
          } failure:^(NSError *error) {
              
          }];
}
-(void)setSaveBtn:(UIButton *)SaveBtn
{
          SaveBtn.layer.masksToBounds=YES;
          
       
          
          SaveBtn.layer.cornerRadius = 30.0*Kscale;
          
         
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
