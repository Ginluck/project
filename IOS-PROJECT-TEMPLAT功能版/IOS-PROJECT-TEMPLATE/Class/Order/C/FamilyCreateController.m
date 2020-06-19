//
//  FamilyCreateController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/7.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "FamilyCreateController.h"
#import "ZHFAddTitleAddressView.h"
#import "UITextView+WJPlaceholder.h"
#import "AddrChooseController.h"
#import <QMapKit/QMapKit.h>
#import <QMapKit/QMSSearchKit.h>
#import "SJActionSheet.h"
@interface FamilyCreateController ()<ZHFAddTitleAddressViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)ZHFAddTitleAddressView * addTitleAddressView;
@property(nonatomic,weak)IBOutlet UIButton * addrBtn;
@property(nonatomic,weak)IBOutlet UITextField * nameTF;
@property(nonatomic,weak)IBOutlet UIButton * detailAddr;
@property(nonatomic,weak)IBOutlet UITextView * contentTV;
@property(nonatomic,weak)IBOutlet UIButton * logoImage;
@property(nonatomic,strong)NSString * provinceId;
@property(nonatomic,strong)NSString * cityId;
@property(nonatomic,strong)NSString * areaId;
@property(nonatomic,strong)NSString * addr;
@property(nonatomic,strong)NSString * imgUrl;
@property(nonatomic,strong)NSString * areaAddr;
@property(nonatomic,strong)NSString * lat;
@property(nonatomic,strong)NSString * lon;
@property(nonatomic,strong)UIImagePickerController *imagePickerVC;
@property(nonatomic,strong)UIImageView *backImage;
@end

@implementation FamilyCreateController
-(UIImageView *)backImage
{
    if (!_backImage) {
        _backImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        _backImage.image =KImageNamed(@"通用背景");
    }
    return _backImage;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitleView:@"创建家族"];
    // Do any additional setup after loading the view from its nib.
//    [self.view addSubview:self.backImage];
    [self.view addSubview:[self.addTitleAddressView initAddressView]];
    self.contentTV.placeholdFont=MKFont(13);


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
-(ZHFAddTitleAddressView*)addTitleAddressView
{
    if (!_addTitleAddressView) {
        _addTitleAddressView = [[ZHFAddTitleAddressView alloc]init];
        _addTitleAddressView.title = @"选择地址";
        _addTitleAddressView.delegate1 = self;
        _addTitleAddressView.defaultHeight = 350;
        _addTitleAddressView.titleScrollViewH = 37;
        if (   _addTitleAddressView.titleIDMarr.count > 0) {
            _addTitleAddressView.isChangeAddress = true;
        }
        else{
            _addTitleAddressView.isChangeAddress = false;
        }
    }
    return _addTitleAddressView;
}
-(IBAction)chooseAddr:(id)sender
{
     [self.addTitleAddressView addAnimate];
}
-(void)cancelBtnClick:(NSString *)titleAddress provinceId:(NSString *)titleID cityId:(NSString *)cityId  areaId:(NSString *)areaId{
    
    NSLog( @"%@", [NSString stringWithFormat:@"id=%@ cid =%@  aid =%@",titleID,cityId,areaId]);
    [self.addrBtn setTitle:titleAddress forState:UIControlStateNormal];
    self.areaAddr =titleAddress;
    self.provinceId=titleID;
    if (cityId.length)
    {
        self.cityId =cityId;
    }
    if (areaId.length)
    {
        self.areaId =areaId;
    }
    
}


-(IBAction)chooseLogo:(UIButton *)sender
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
        DismissHud();
        self.imgUrl =result[@"url"];
       [ self.logoImage sd_setImageWithURL:[NSURL URLWithString:result[@"url"]] forState:UIControlStateNormal];
    } failure:^(NSError *error) {
        DismissHud();
    }];
}

-(IBAction)createFamily:(id)sender
{
    if (!self.nameTF.text.length)
    {
        ShowMessage(@"请输入家族名称");
        return;
    }
    if (!self.provinceId.length)
    {
        ShowMessage(@"请选择家庭区域");
        return;
    }
    if (!self.addr.length)
    {
        ShowMessage(@"请选择具体地址");
        return;
    }
    if (!self.contentTV.text.length)
    {
        ShowMessage(@"请输入家族简介");
        return;
    }
    UserModel * model =[[UserManager shareInstance]getUser];
    NSMutableDictionary * paramDic =[NSMutableDictionary dictionaryWithDictionary:@{@"provinceId":self.provinceId,@"cityId":self.cityId,@"areaId":self.areaId,@"address":self.addr,@"introduce":self.contentTV.text,@"name":self.nameTF.text,@"userUserId":model.id,@"lat":self.lat,@"lon":self.lon,@"pcaName":self.areaAddr}];
    if (self.imgUrl.length)
    {
        [paramDic setValue:@"img" forKey:self.imgUrl];
    }

    [RequestHelp POST:JS_CREATE_FAMILY_URL parameters:paramDic success:^(id result) {
        MKLog(@"%@",result);
        ShowMessage(@"创建成功");
        UserModel * model =[[UserManager shareInstance]getUser];
        model.patriarch =@"1";
//        if (!model.jzId.length)
//        {
//               model.jzId =(NSString*)result;
//        }
//        else
//        {
//            if ([model.jzId containsString:@","]) {
//                 NSMutableArray  * arr =  [NSMutableArray arrayWithArray: [model.jzId componentsSeparatedByString:@","]];
//                [arr  addObject:result];
//                model.jzId =[arr componentsJoinedByString:@","];
//            }
//            else
//            {
//                NSMutableArray * arr =[NSMutableArray array];
//                [arr addObject:model.jzId];
//                [arr addObject:result];
//                model.jzId =[arr componentsJoinedByString:@","];
//            }
//           
//        }
//     
        [[UserManager shareInstance]saveUser:model];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}



-(IBAction)chooseAddrClick:(id)sender
{
    if (!self.provinceId.length) {
        ShowMessage(@"请先选择家族地区");
        return;
    }
    AddrChooseController * avc =[AddrChooseController new];
    avc.selectedRoomBlock = ^(NSObject * _Nonnull model) {
        if ([model isKindOfClass:[QMSReGeoCodePoi class]])
        {
            QMSReGeoCodePoi * code =(QMSReGeoCodePoi*)model;
            [self.detailAddr setTitle:code.title forState:UIControlStateNormal];
            self.addr =code.title;
            self.lon =[NSString stringWithFormat:@"%f",code.location.longitude];
            self.lat =[NSString stringWithFormat:@"%f",code.location.latitude];
        }
        else if ([model isKindOfClass:[QMSSuggestionPoiData class]])
        {
            QMSSuggestionPoiData * code =(QMSSuggestionPoiData*)model;
            self.addr =code.title;
            [self.detailAddr setTitle:code.title forState:UIControlStateNormal];
            self.lon =[NSString stringWithFormat:@"%f",code.location.longitude];
            self.lat =[NSString stringWithFormat:@"%f",code.location.latitude];
        }
    };
    [self.navigationController pushViewController:avc animated:YES];
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
