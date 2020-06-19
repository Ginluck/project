//
//  SetHeadViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/13.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "SetHeadViewController.h"
#import "MyIntroductionViewController.h"
#import "SheZhiNameViewController.h"
#import "AddrChooseController.h"
#import "MineDataModel.h"
#import "PhoneChangeViewController.h"
#import "SJActionSheet.h"
@interface SetHeadViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UIImagePickerController *imagePickerVC;
@property(nonatomic,strong)UIView *BackGroundView;
@property(nonatomic,strong)NSString *HeadImgStr;
@end

@implementation SetHeadViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self requsetData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitleView:@"个人资料"];
    
    // Do any additional setup after loading the view from its nib.
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
       } failure:^(NSError *error) {
           
       }];
}
- (IBAction)Click:(UIButton *)sender {
//     WS(weakSelf);
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
                           PhoneChangeViewController *SZNVC=[PhoneChangeViewController new];
                           [self.navigationController pushViewController:SZNVC animated:YES];
                       }
                           break;
            case 102:
            {
                SheZhiNameViewController *SZNVC=[SheZhiNameViewController new];
                SZNVC.NameStr =self.Namelab.text;
                [self.navigationController pushViewController:SZNVC animated:YES];
            }
                break;
            case 103:
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
                    [self UpdateMyData];
                };
                [self.navigationController pushViewController:avc animated:YES];
            }
                break;
            case 104:
            {
                MyIntroductionViewController *SZNVC=[MyIntroductionViewController new];
                [self.navigationController pushViewController:SZNVC animated:YES];
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
        self.imagePickerVC.allowsEditing =YES;//这两句保证了图片可以裁剪为正方形

        self.imagePickerVC.allowsImageEditing=YES;///这两句保证了图片可以裁剪为正方形
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
        [self.HeadImg sd_setImageWithURL:[NSURL URLWithString:self.HeadImgStr] placeholderImage:[UIImage imageNamed:@"临时占位图"]];
        [self UpdateMyData];
    } failure:^(NSError *error) {
        DismissHud();
    }];
}

-(void)UpdateMyData
{
     UserModel * model =[[UserManager shareInstance]getUser];
    NSDictionary* param_dic =@{@"userPhone":model.userPhone,@"realName":self.Namelab.text,@"address":self.AddressLab.text,@"headAddress":self.HeadImgStr};
          [RequestHelp POST:UPDATE_ZJ_url parameters:param_dic success:^(id result) {
              MKLog(@"%@",result);
              ShowMessage(@"修改成功");
              model.realName=self.Namelab.text;
              model.address=self.AddressLab.text;
              model.headAddress=self.HeadImgStr;
            [[UserManager shareInstance]saveUser:model];
          } failure:^(NSError *error) {
              
          }];
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
