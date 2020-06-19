//
//  AddPersonCitangController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/28.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "AddPersonCitangController.h"
#import "UITextView+WJPlaceholder.h"
#import "CitangDetailModel.h"
#import "SJActionSheet.h"
@interface AddPersonCitangController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,weak)IBOutlet UITextField * nameTF;
@property(nonatomic,weak)IBOutlet UITextView * introTV;
@property(nonatomic,weak)IBOutlet UIButton * citangImage;
@property(nonatomic,strong)UIImagePickerController *imagePickerVC;
@property(nonatomic,strong)NSString * imgUrl;
@property(nonatomic,strong)CitangDetailModel * DetailModel;
@end

@implementation AddPersonCitangController
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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavigationTitleView:@"个人祠堂"];
    self.introTV.placeholdFont =MKFont(14);
    if (self.model !=nil) {
        [self requestData];
    }
}


-(void)requestData
{
    [RequestHelp POST:JS_CITANG_DETAIL_URL parameters:@{@"id":self.model.id} success:^(id result) {
        self.DetailModel =[CitangDetailModel yy_modelWithJSON:result];
        [self refreshUI];
    } failure:^(NSError *error) {
        
    }];
}
-(void)refreshUI
{
    self.nameTF.text =self.DetailModel.name;
    self.introTV.text =self.DetailModel.ctJs;
    self.introTV.placeholder =@"";
    self.imgUrl =self.DetailModel.img;
    [self.citangImage sd_setImageWithURL:[NSURL URLWithString:self.DetailModel.img] forState:UIControlStateNormal];
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
        [ self.citangImage sd_setImageWithURL:[NSURL URLWithString:result[@"url"]] forState:UIControlStateNormal];
    } failure:^(NSError *error) {
        DismissHud();
    }];
}

-(IBAction)createCitang
{
    if (!self.nameTF.text.length)
    {
        ShowMessage(@"请输入祠堂名称 ");return;
    }
    if (!self.introTV.text.length)
    {
        ShowMessage(@"请输入祠堂介绍 ");return;
    }
    if (!self.imgUrl.length)
    {
        ShowMessage(@"请选择祠堂图片 ");return;
    }
    if (self.model ==nil) {
        NSDictionary *dic =@{@"type":@"1",@"name":self.nameTF.text,@"ctJs":self.introTV.text,@"img":self.imgUrl};
        [RequestHelp POST:JS_CREATE_CITANG_URL parameters:dic success:^(id result) {
            MKLog(@"%@",result);
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            
        }];
    }
    else
    {
        NSDictionary *dic =@{@"type":@"1",@"name":self.nameTF.text,@"ctJs":self.introTV.text,@"img":self.imgUrl,@"id":self.model.id};
        [RequestHelp POST:JS_CITANG_UPDATE_URL parameters:dic success:^(id result) {
            MKLog(@"%@",result);
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            
        }];
    }
    
}


@end
