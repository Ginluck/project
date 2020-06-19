//
//  AddFamilyCitangController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/28.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "AddFamilyCitangController.h"
#import "UITextView+WJPlaceholder.h"
#import "ChooseFamilyController.h"
#import "FamilyListModel.h"
#import "ChooseMemberController.h"
#import "FamilyTreeMember.h"
#import "CitangDetailModel.h"
#import "SJActionSheet.h"
@interface AddFamilyCitangController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,weak)IBOutlet UITextField * nameTF;
@property(nonatomic,weak)IBOutlet UITextView * introTV;
@property(nonatomic,weak)IBOutlet UIButton * familyBtn;
@property(nonatomic,weak)IBOutlet UIButton * memberBtn;
@property(nonatomic,weak)IBOutlet UIButton * citangImage;
@property(nonatomic,strong) FamilyListModel * family;
@property(nonatomic,strong) NSString * IdStr;
@property(nonatomic,strong) NSString * countStr;
@property(nonatomic,strong)NSString * imgUrl;
@property(nonatomic,strong)CitangDetailModel * DetailModel;
@property(nonatomic,strong)NSArray * selectedArr;
@property(nonatomic,strong)UIImagePickerController *imagePickerVC;
@end

@implementation AddFamilyCitangController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavigationTitleView:@"创建家庭私人祠堂"];
    self.introTV.placeholdFont =MKFont(14);
    if (self.model !=nil) {
        [self requestData];
    }
}

-(void)requestData
{
    [RequestHelp POST:JS_CITANG_DETAIL_URL parameters:@{@"id":self.model.id} success:^(id result) {
        MKLog(@"%@",result);
       self.DetailModel =[CitangDetailModel yy_modelWithJSON:result];
       [self refreshUI];
    } failure:^(NSError *error) {
        
    }];
}
-(void)refreshUI
{
    self.nameTF.text =self.DetailModel.name;
    self.introTV.text =self.DetailModel.ctJs;
    self.imgUrl =self.DetailModel.img2;
    [self.citangImage sd_setImageWithURL:[NSURL URLWithString:self.DetailModel.img2] forState:UIControlStateNormal];
    
    self.family =[FamilyListModel new];
    self.family.id =self.DetailModel.jzId;
    [self.familyBtn setTitle:self.DetailModel.name2 forState:UIControlStateNormal];
    
    NSMutableArray * nameArr =[NSMutableArray array];
     NSMutableArray * idArr =[NSMutableArray array];
    for (FamilyTreeMember * member in self.DetailModel.zpList)
    {
        [nameArr addObject:member.name];
        [idArr addObject:member.id];
    }
    [self.memberBtn setTitle:[nameArr componentsJoinedByString:@","] forState:UIControlStateNormal];
    self.IdStr =[idArr componentsJoinedByString:@","];
    self.selectedArr=self.DetailModel.zpList;
}

-(IBAction)chooseClick:(UIButton *)sender
{
    if (sender.tag ==5) {
        ChooseFamilyController * cvc =[ChooseFamilyController new];
        cvc.block = ^(FamilyListModel * _Nonnull model) {
            [self.familyBtn setTitle:model.name forState:UIControlStateNormal];
            self.family =model;
        };
        self.IdStr =@"";
        [self.memberBtn setTitle:@"请选择祭祀成员" forState:UIControlStateNormal];
        [self.navigationController pushViewController:cvc animated:YES];
    }
    else if (sender.tag ==6)
    {
        if (self.family ==nil) {
            ShowMessage(@"请先选择家族");return;
        }
        ChooseMemberController * cc =[ChooseMemberController new];
        cc.model =self.family;
        if (self.selectedArr.count) {
            cc.selctedArr =self.selectedArr;
        }
        cc.block = ^(NSArray * _Nonnull arr) {
            NSMutableArray * nameArr =[NSMutableArray array];
            NSMutableArray * idArr =[NSMutableArray array];
           NSMutableArray * countArr =[NSMutableArray array];
            for (FamilyTreeMember * member in arr)
            {
                [nameArr addObject:member.name];
               [ idArr addObject:member.id];
                [countArr addObject:member.count];
            }
            self.selectedArr =arr;
            [self.memberBtn setTitle:[nameArr componentsJoinedByString:@","] forState:UIControlStateNormal];
            self.countStr =[countArr componentsJoinedByString:@","];
            self.IdStr =[idArr componentsJoinedByString:@","];
        };
        [self.navigationController pushViewController:cc animated:YES];
    }
    else if (sender.tag ==7)
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
        
//        
//        
//        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"选择图片" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
//        
//        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [self selectImageFromCamera];
//        }];
//        
//        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [self selectImageFromAlbum];
//        }];
//        
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//        [alertVc addAction:cameraAction];
//        [alertVc addAction:photoAction];
//        [alertVc addAction:cancelAction];
//        [self presentViewController:alertVc animated:YES completion:nil];

    }
    else
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
        if (!self.family.id.length)
        {
            ShowMessage(@"请选择祭祀家族 ");return;
        }
        if (!self.IdStr.length)
        {
            ShowMessage(@"请选择祭祀成员 ");return;
        }
        if (self.model ==nil) {
            NSDictionary *dic =@{@"type":@"2",@"name":self.nameTF.text,@"ctJs":self.introTV.text,@"img":self.imgUrl,@"jzId":self.family.id,@"memberId":self.IdStr,@"count":self.countStr};
            [RequestHelp POST:JS_CREATE_CITANG_URL parameters:dic success:^(id result) {
                MKLog(@"%@",result);
                [self.navigationController popViewControllerAnimated:YES];
            } failure:^(NSError *error) {
                
            }];
        }
        else
        {
            NSDictionary *dic =@{@"type":@"2",@"name":self.nameTF.text,@"ctJs":self.introTV.text,@"img":self.imgUrl,@"jzId":self.family.id,@"memberId":self.IdStr,@"id":self.model.id,@"count":self.countStr};
            [RequestHelp POST:JS_CITANG_UPDATE_URL parameters:dic success:^(id result) {
                MKLog(@"%@",result);
                [self.navigationController popViewControllerAnimated:YES];
            } failure:^(NSError *error) {
                
            }];
        }

    }

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

@end
