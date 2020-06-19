//
//  WorshipController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/29.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "WorshipController.h"
#import "AddPersonCitangController.h"
#import "AddFamilyCitangController.h"
#import "JisiProController.h"
#import "CitangDetailModel.h"
#import "NSString+Fit.h"
#import "ImageBigger.h"
#import "GongfengRecordController.h"
#import "JipinModel.h"
#import "JipinSetModel.h"
#import "UILabel+WY_Extension.h"
#import "PaiWeiView.h"
#import "SJActionSheet.h"
@interface WorshipController ()
@property(nonatomic,strong)UIImageView * backImage;
@property(nonatomic,strong)CitangDetailModel * DetailModel;
@property(nonatomic,strong)UIImageView * jisiImage;//排位图
@property(nonatomic,strong)UIImageView * itemImage;//购买商品的图片
@property(nonatomic,strong)UIImageView * gifImage;//gif的图片
@property(nonatomic,strong)JipinChild * itemChild;
@property(nonatomic,strong)JipinSetModel * itemModel;
@property(nonatomic,strong)UIImageView * table_1;//供桌1
@property(nonatomic,strong)UIImageView * table_2;//供桌2

@property(nonatomic,strong)NSMutableArray * table1_imageArr;
@property(nonatomic,strong)NSMutableArray * table2_imageArr;
@end

@implementation WorshipController


-(NSMutableArray *)table1_imageArr
{
    if (!_table1_imageArr)
    {
        _table1_imageArr =[NSMutableArray array];
    }
    return _table1_imageArr;
}

-(NSMutableArray *)table2_imageArr
{
    if (!_table2_imageArr)
    {
        _table2_imageArr =[NSMutableArray array];
    }
    return _table2_imageArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self reloadUICompoents];
    [self requestData];
    [self setGPRequest];
}


-(void)reloadUICompoents
{
 
    [self.view addSubview:self.backImage];
    
    UIButton * btn_1 =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn_1 setNormalTitle:@"点长明灯" font:MKFont(15) titleColor:[UIColor whiteColor]];
    btn_1.backgroundColor =K_Prokect_MainColor;
    btn_1.frame =CGRectMake(30, Screen_Height-60, Screen_Width/2-40, 40);
    btn_1.layer.cornerRadius =4.f;
    btn_1.layer.masksToBounds =YES;
    [self.view addSubview:btn_1];
    
    UIButton * btn_2 =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn_2 setNormalTitle:@"我要祭拜" font:MKFont(15) titleColor:[UIColor whiteColor]];
    btn_2.backgroundColor =K_Prokect_MainColor;
    btn_2.frame =CGRectMake(Screen_Width/2+10, Screen_Height-60, Screen_Width/2-40, 40);
    btn_2.layer.cornerRadius =4.f;
    btn_2.layer.masksToBounds =YES;
    [btn_2 addTarget:self action:@selector(buyProClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_2];
    
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake(Screen_Width-50, Screen_Height-K_BottomHeight-105, 30, 30);
    [button setImage:KImageNamed(@"add1") forState:UIControlStateNormal];
    button.layer.cornerRadius =15.f;
    button.layer.masksToBounds=YES;
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    CGFloat table_scale_x =0.4;
    CGFloat table_width =Screen_Width*2/3;
    CGFloat table_width2 =Screen_Width/2;
    
    _table_2= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, table_width2, (table_width2)*table_scale_x)];
    _table_2.center =CGPointMake(Screen_Width/2, CGRectGetMinY(btn_1.frame)-(table_width2)*table_scale_x/2-75);
    MKLog(@"%f",Screen_Height-K_NaviHeight);;
    _table_2.image =KImageNamed(@"供桌");
    [self.view addSubview:_table_2];
    _table_1= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, table_width, (table_width)*table_scale_x)];
     _table_1.center =CGPointMake(Screen_Width/2, CGRectGetMinY(btn_1.frame)-(table_width)*table_scale_x/2-5);
    MKLog(@"%f",Screen_Height-K_NaviHeight);;
    _table_1.image =KImageNamed(@"供桌");
    [self.view addSubview:_table_1];
    
    
    CGFloat item_width =table_width/7;
    UIImageView * luzi_image =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, item_width, item_width/2)];
    luzi_image.center =CGPointMake(Screen_Width/2, CGRectGetMinY(_table_1.frame)-item_width/4);
    luzi_image.image =KImageNamed(@"香炉2");
    luzi_image.contentMode =UIViewContentModeScaleAspectFit;
    [self.view addSubview:luzi_image];
    
    

    
//
//    CGFloat image_Width =245*Screen_Width /1080;
//    CGFloat image_Height =310*(Screen_Height-K_NaviHeight)/1560;
    
//    UIImageView * image =[[UIImageView alloc]initWithImage:KImageNamed(@"背景1")];
//    image.bounds =CGRectMake(0, 0, image_Width, image_Height);
//    image.center =CGPointMake(Screen_Width/2,K_NaviHeight+(Screen_Height-K_NaviHeight)/(1560/113)+image_Height/2);
//    [self.view addSubview:image];
    
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"发光gif" ofType:@"gif"];
//    NSData *gifData = [NSData dataWithContentsOfFile:path];
//    UIWebView *webView  = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
//    webView.center =CGPointMake(Screen_Width/2, 200);
//    webView.scalesPageToFit = YES;
//    [webView loadData:gifData MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
//    webView.backgroundColor = [UIColor clearColor];
//    webView.opaque = NO;
//    [self.view addSubview:webView];

}
-(UIImageView *)itemImage
{
    if (!_itemImage) {
        _itemImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 75, 75)];
        _itemImage .center =CGPointMake(Screen_Width/2, 200);
    }
    return _itemImage;
}

-(void)click
{
    
    SJActionSheet *actionSheet = [[SJActionSheet alloc] initSheetWithTitle:nil style:SJSheetStyleDefault itemTitles:@[@"修改祠堂",@"供奉记录"]];
    actionSheet.itemTextFont =MKFont(13);
    actionSheet.cancelTextFont =MKFont(13);
    actionSheet.itemTextColor =K_Prokect_MainColor;
    actionSheet.cancleTextColor=K_PROJECT_GARYTEXTCOLOR;
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        if ([title isEqualToString:@"修改祠堂"])
        {
            if ([self.model.type isEqualToString:@"1"]  ||([self.model.type isEqualToString:@"0"]&&[self.DetailModel.isAdmin isEqualToString:@"1"]))
            {
                AddPersonCitangController * avc =[AddPersonCitangController new];
                avc.model =self.model;
                [self.navigationController pushViewController:avc animated:YES];
            }
            else if ([self.model.type isEqualToString:@"0"] && [self.DetailModel.isAdmin isEqualToString:@"0"])
            {
                ShowMessage(@"暂无权限修改");
                return ;
            }
            else if ([self.model.type isEqualToString:@"2"])
            {
                AddFamilyCitangController * avc =[AddFamilyCitangController new];
                avc.model=self.model;
                [self.navigationController pushViewController:avc animated:YES];
            }
        }
        else if ([title isEqualToString:@"供奉记录"])
        {
            GongfengRecordController * gc=[[GongfengRecordController alloc]init];
            gc.model =self.model;
            [self.navigationController pushViewController:gc animated:YES];
        }
    }];

}
- (void)showGifByImageView {
    NSURL *gifUrl = [[NSBundle mainBundle] URLForResource:@"发光gif" withExtension:@"gif"];
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)gifUrl, NULL);
    size_t imageCount = CGImageSourceGetCount(gifSource);
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    for (size_t i = 0; i < imageCount; i++) {
        //获取源图片
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        [mutableArray addObject:image];
        CGImageRelease(imageRef);
    }
    _gifImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    _gifImage.center =CGPointMake(Screen_Width/2, 200);
    _gifImage.animationImages = mutableArray;
    _gifImage.contentMode = UIViewContentModeScaleAspectFit;
    _gifImage.animationDuration = 5;
    [_gifImage startAnimating];
    [self.view addSubview:_gifImage];
    CFRelease(gifSource);
}
-(UIImageView *)backImage
{
    if (!_backImage) {
        _backImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, K_NaviHeight, Screen_Width, Screen_Height-K_NaviHeight)];
        _backImage .image =KImageNamed(@"背景1");
        _backImage.backgroundColor =[UIColor clearColor];
    }
    return _backImage;
}

-(void)requestData
{
    [RequestHelp POST:JS_CITANG_DETAIL_URL parameters:@{@"id":self.model.id} success:^(id result) {
        MKLog(@"%@",result);
        self.DetailModel =[CitangDetailModel yy_modelWithJSON:result];
        for (int i=0; i<self.DetailModel.zpList2.count; i++)
        {
            FamilyTreeModel * model=self.DetailModel.zpList2[i];
            model.lisCount= [NSString stringWithFormat:@"%ld",model.list.count];
        }
        [self refreshPaiWei];
    } failure:^(NSError *error) {}];
    

}

-(void)setGPRequest
{
    [RequestHelp POST:JS_JIPINPUT_URL parameters:@{@"ctId":self.model.id} success:^(id result) {
        self.itemModel =[JipinSetModel yy_modelWithJSON:result];
        [self setTable1Data];
        [self setTable2Data];
        [self setHuaQuanData];
    } failure:^(NSError *error) {
        
    }];
}
-(void)setTable1Data
{
    for (UIImageView *image in self.table1_imageArr) {
        [image removeFromSuperview];
    }
    CGFloat item_width =CGRectGetWidth(self.table_1.frame)/7;
    CGPoint table_item_point1 =CGPointMake(CGRectGetMinX(self.table_1.frame), CGRectGetMinY(self.table_1.frame)-item_width);
    CGPoint table_item_point2 =CGPointMake(CGRectGetMinX(self.table_1.frame)+item_width, CGRectGetMinY(self.table_1.frame)-item_width);
    CGPoint table_item_point3 =CGPointMake(CGRectGetMinX(self.table_1.frame)+item_width*2, CGRectGetMinY(self.table_1.frame)-item_width);
    CGPoint table_item_point4 =CGPointMake(CGRectGetMinX(self.table_1.frame)+item_width*3, CGRectGetMinY(self.table_1.frame)-item_width+5);
    CGPoint table_item_point5 =CGPointMake(CGRectGetMinX(self.table_1.frame)+item_width*4, CGRectGetMinY(self.table_1.frame)-item_width);
    CGPoint table_item_point6 =CGPointMake(CGRectGetMinX(self.table_1.frame)+item_width*5, CGRectGetMinY(self.table_1.frame)-item_width+5);
    CGPoint table_item_point7 =CGPointMake(CGRectGetMinX(self.table_1.frame)+item_width*6, CGRectGetMinY(self.table_1.frame)-item_width);
    
    
    NSMutableArray * imageArr =[NSMutableArray array];
    NSMutableArray * teshuImage =[NSMutableArray array];
    //第1部创建控件
    for (int i=0; i<7; i++)
    {
        UIImageView * image =[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.table_1.frame)+i*item_width, CGRectGetMinY(self.table_1.frame)-item_width, item_width, item_width)];
        [imageArr addObject:image];
       
    }
    
    
    
    //第2步确定坐标
    
    NSArray* arr =@[[NSValue valueWithCGPoint:table_item_point6],[NSValue valueWithCGPoint:table_item_point2],[NSValue valueWithCGPoint:table_item_point7],[NSValue valueWithCGPoint:table_item_point1]];
    
    if (self.itemModel.first.xiangList.count)
    {
        GongFengListModel * model =self.itemModel.first.xiangList[0];
        model.position_x =table_item_point4.x;
        model.position_y=table_item_point4.y;
        
        UIImageView * xiang =imageArr[3];
        xiang.frame =CGRectMake(CGRectGetMinX(self.table_1.frame)+3*item_width, CGRectGetMinY(self.table_1.frame)-item_width-5, item_width, item_width);
        [self.view addSubview:xiang];
        [xiang sd_setImageWithURL:[NSURL URLWithString:model.jpImgUrl]];
        [self.table1_imageArr addObject:xiang];
        
    }
    
    if (self.itemModel.first.laList.count)
    {
        GongFengListModel * model =self.itemModel.first.laList[0];
        model.position_x =table_item_point3.x;
        model.position_y=table_item_point3.y;
    
        UIImageView * la_1 =imageArr[2];
        UIImageView * la_2 =imageArr[4];
        [la_1 sd_setImageWithURL:[NSURL URLWithString:model.jpImgUrl]];
        [la_2 sd_setImageWithURL:[NSURL URLWithString:model.jpImgUrl]];
        [self.view addSubview:la_1];
        [self.view addSubview:la_2];
        model.x_postion =table_item_point5.x;
        model.y_postion=table_item_point5.y;
        [self.table1_imageArr addObject:la_1];
        [self.table1_imageArr addObject:la_2];
    }
    if (self.itemModel.first.qitaList.count)
    {
        for (int i=0; i<self.itemModel.first.qitaList.count; i++)
        {
            GongFengListModel * model =self.itemModel.first.qitaList[i];
            CGPoint postion = [arr[i] CGPointValue];
            model.position_x =postion.x;
            model.position_y=postion.y;
            
            UIImageView * image =[[UIImageView alloc]initWithFrame:CGRectMake(model.position_x, model.position_y
                                                                              , item_width, item_width)];
            [image sd_setImageWithURL:[NSURL URLWithString:model.jpImgUrl]];
            image.contentMode =UIViewContentModeScaleAspectFit;
            [self.view addSubview:image];
            [self.table1_imageArr addObject:image];
        }
    }
  
}
-(void)setTable2Data
{
    for (UIImageView *image in self.table2_imageArr) {
        [image removeFromSuperview];
    }
    CGFloat item_width =CGRectGetWidth(self.table_2.frame)/7;
    CGPoint table_item_point1 =CGPointMake(CGRectGetMinX(self.table_2.frame), CGRectGetMinY(self.table_2.frame)-item_width);
    CGPoint table_item_point2 =CGPointMake(CGRectGetMinX(self.table_2.frame)+item_width, CGRectGetMinY(self.table_2.frame)-item_width);
    CGPoint table_item_point3 =CGPointMake(CGRectGetMinX(self.table_2.frame)+item_width*2, CGRectGetMinY(self.table_2.frame)-item_width);
    CGPoint table_item_point4 =CGPointMake(CGRectGetMinX(self.table_2.frame)+item_width*3, CGRectGetMinY(self.table_2.frame)-item_width);
    CGPoint table_item_point5 =CGPointMake(CGRectGetMinX(self.table_2.frame)+item_width*4, CGRectGetMinY(self.table_2.frame)-item_width);
    CGPoint table_item_point6 =CGPointMake(CGRectGetMinX(self.table_2.frame)+item_width*5, CGRectGetMinY(self.table_2.frame)-item_width);
    CGPoint table_item_point7 =CGPointMake(CGRectGetMinX(self.table_2.frame)+item_width*6, CGRectGetMinY(self.table_2.frame)-item_width);
    
        NSArray* arr =@[[NSValue valueWithCGPoint:table_item_point4],[NSValue valueWithCGPoint:table_item_point5],[NSValue valueWithCGPoint:table_item_point3],[NSValue valueWithCGPoint:table_item_point6],[NSValue valueWithCGPoint:table_item_point2],[NSValue valueWithCGPoint:table_item_point7],[NSValue valueWithCGPoint:table_item_point1]];
    
    
    if (self.itemModel.second.count)
    {
        for (int i=0; i<self.itemModel.second.count; i++)
        {
            GongFengListModel * model =self.itemModel.second [i];
            
            CGPoint postion = [arr[i] CGPointValue];
            model.position_x =postion.x;
            model.position_y=postion.y;
            
            UIImageView * image =[[UIImageView alloc]initWithFrame:CGRectMake(model.position_x, model.position_y+2
                                                                              , item_width, item_width)];
            [image sd_setImageWithURL:[NSURL URLWithString:model.jpImgUrl]];
            image.contentMode =UIViewContentModeScaleAspectFit;
            [self.view addSubview:image];
            [self.table2_imageArr addObject:image];
            
        }
    }
}

-(void)setHuaQuanData
{
    CGFloat item_width =Screen_Width/4 *0.8;
    
    CGPoint table_item_point1 =CGPointMake(Screen_Width/8, CGRectGetMinY(self.table_2.frame));
    CGPoint table_item_point2 =CGPointMake(Screen_Width/8*7, CGRectGetMinY(self.table_2.frame));
    
    NSArray* arr =@[[NSValue valueWithCGPoint:table_item_point2],[NSValue valueWithCGPoint:table_item_point1]];
    if (self.itemModel.third.count)
    {
        for (int i=0; i<self.itemModel.third.count; i++)
        {
            GongFengListModel * model =self.itemModel.third [i];
            if (i<2) {
                CGPoint postion = [arr[i] CGPointValue];
                model.position_x =postion.x;
                model.position_y=postion.y;
                
                UIImageView * image =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0
                                                                                  , item_width, item_width)];
                image.center =CGPointMake(model.position_x, model.position_y);
                [image sd_setImageWithURL:[NSURL URLWithString:model.jpImgUrl]];
                image.contentMode =UIViewContentModeScaleAspectFit;
                [self.view addSubview:image];
                [self.table2_imageArr addObject:image];
            }
        }
    }
}

-(void)buyProClick
{
    JisiProController * jvc =[JisiProController new];
    jvc.model=self.model;
    jvc.block = ^(JipinChild * _Nonnull model) {
        self.itemChild =model;
        [self showGifByImageView];
        [self.itemImage sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
        [self.view addSubview:self.itemImage];
        [self performSelector:@selector(remove) withObject:nil afterDelay:5.0f];
    };
    [self.navigationController pushViewController:jvc animated:YES];
}
-(void)remove
{
    [self.itemImage removeFromSuperview];
    [self.gifImage removeFromSuperview];
    [self setGPRequest];
}

-(void)refreshPaiWei
{
    NSMutableArray * countArr =[NSMutableArray array];
    
    for (int i=0; i<self.DetailModel.zpList2.count; i++)
    {
        FamilyTreeModel * model=self.DetailModel.zpList2[i];
        
        [countArr addObject:model.lisCount];
    }
    CGFloat width =32.f;
    
    CGFloat height =64.f;
    
    CGFloat  margin_y =20;
    
    CGFloat Margin_x =(Screen_Width -8*width)/9;
    
    
    UIView * bgView =[[UIView alloc]initWithFrame:CGRectMake(0, K_NaviHeight, Screen_Width, Screen_Height-K_NaviHeight)];
   
    UIScrollView * scView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, CGRectGetHeight(bgView.frame))];
    [bgView addSubview:scView];
    
    for (int i=0; i<self.DetailModel.zpList2.count; i++)
    {
        FamilyTreeModel * model =self.DetailModel.zpList2[i];
        
        for (int j=0; j<model.list.count;j++)
        {
            FamilyTreeMember * member =model.list[j];
            if ([model.lisCount isEqualToString:@"1"])
            {
                PaiWeiView * pView =[[PaiWeiView alloc]initWithFrame:CGRectMake(0, 0, width, height)];;
                pView.nameLabel.verticalText =member.name;
                pView.center= CGPointMake(Screen_Width/2, margin_y+height/2+(height +margin_y)*i);
                [scView addSubview:pView];
            }
            if ([model.lisCount integerValue]>1 &&[model.lisCount integerValue]<9)
            {
            
                 Margin_x =(Screen_Width -[model.lisCount integerValue]*width)/([model.lisCount integerValue]+1);
                PaiWeiView * pView =[[PaiWeiView alloc]initWithFrame:CGRectMake(Margin_x +(width +Margin_x)*j, margin_y+(height +margin_y)*i, width, height)];;
                pView.nameLabel.verticalText =member.name;
                [scView addSubview:pView];
            }
            else if ([model.lisCount integerValue]>8)
            {
                Margin_x =(Screen_Width -8*width)/9;
                PaiWeiView * pView =[[PaiWeiView alloc]initWithFrame:CGRectMake(Margin_x +(width +Margin_x)*j, margin_y+(height +margin_y)*i, width, height)];;
                pView.nameLabel.verticalText =member.name;
                scView.contentSize =CGSizeMake(Margin_x+(width+Margin_x)*[model.lisCount integerValue], 0);
                [scView addSubview:pView];
            }
        }
    }
//    [self.view addSubview:bgView];
        CGFloat image_Width =245*Screen_Width /1080;
        CGFloat image_Height =310*(Screen_Height-K_NaviHeight)/1560;

        UIImageView * image =[[UIImageView alloc]init];
    if ([self.model.type isEqualToString:@"1"]   || (self.DetailModel.zpList2.count ==0 &&[self.model.type isEqualToString:@"0"]))
    {
        [image sd_setImageWithURL:[NSURL URLWithString:self.DetailModel.img]];
    }
    else
    {
        image.image =[self shotShareImage:bgView];
    }
    image.bounds =CGRectMake(0, 0, image_Width, image_Height);
        image.center =CGPointMake(Screen_Width/2,K_NaviHeight+(Screen_Height-K_NaviHeight)/(1560/113)+image_Height/2);
         image.userInteractionEnabled = YES;

        [self.view addSubview:image];
        _jisiImage =image;
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magnifyImage)];
    [image addGestureRecognizer:tap];

}
-(void)magnifyImage
{
    [ImageBigger showImage:_jisiImage];
}
- (UIImage *)shotShareImage:(UIView * )bgView {
    //模糊方法
//    UIGraphicsBeginImageContext(CGSizeMake(self.layer.bounds.size.width, self.layer.bounds.size.height));
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [self.layer renderInContext:context];
//    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return tImage;
    
    //高清方法
    //第一个参数表示区域大小 第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    CGSize size = CGSizeMake(Screen_Width, Screen_Height-K_NaviHeight);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [bgView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
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
