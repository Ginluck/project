//
//  OrderHomeController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2019/12/10.
//  Copyright © 2019年 梦境网络. All rights reserved.
//

#import "OrderHomeController.h"
#import "XunzuCell.h"
#import "FamilyCreateController.h"
#import "YCXMenu.h"
#import "YCXMenuItem.h"
#import "FamilyListModel.h"
//引入地图库头文件
#import <QMapKit/QMapKit.h>
#import "FamilyDescController.h"
#import "MoneyRecordViewController.h"
#import "QiandaoView.h"
#import "SignModel.h"
@interface OrderHomeController ()<QMapViewDelegate,UITextFieldDelegate,QiandaoViewDelegate>

@property(nonatomic,strong)NSMutableArray  * dataAry ;
@property(nonatomic,strong)UIButton *  bgButton;
@property(nonatomic,strong)NSMutableArray  * nameAry ;
@property(nonatomic,assign)NSInteger  page;
@property (nonatomic, strong) QMapView *mapView;
@property(nonatomic,strong)QiandaoView * qView;
@property(nonatomic,strong)SignModel * model;
@end

@implementation OrderHomeController

-(UIButton *)bgButton
{
    if (!_bgButton) {
        _bgButton =[UIButton buttonWithType:UIButtonTypeCustom];
        _bgButton .frame =CGRectMake(0, 0, Screen_Width, Screen_Height);
        _bgButton.backgroundColor =COLOR(0, 0, 0, 0.6);
        //        [_bgButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationTitleView:@"寻祖"];
    self.dataAry =[NSMutableArray array];
//    [self addNavigationItemWithTitle:@"创建家族" itemType:kNavigationItemTypeRight action:@selector(createFamily)];
    [self setUICompoents];
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake(Screen_Width-50, Screen_Height-K_BottomHeight-85, 30, 30);
    [button setImage:KImageNamed(@"add1") forState:UIControlStateNormal];
    button.layer.cornerRadius =15.f;
    button.layer.masksToBounds=YES;
    [button addTarget:self action:@selector(createFamily) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [self requestData];
    
    UIButton * button1 =[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame =CGRectMake(Screen_Width-60, K_NaviHeight+10, 50, 50);
    [button1 setImage:KImageNamed(@"签到入口") forState:UIControlStateNormal];
    button1.layer.cornerRadius =15.f;
    button1.layer.masksToBounds=YES;
    [button1 addTarget:self action:@selector(qiandao) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
}

-(void)qiandaoClose
{
    [self.bgButton removeFromSuperview];
    [self.qView removeFromSuperview];
}
-(void)qiandaoClick
{
    [RequestHelp POST:JS_SIGNIN_URL parameters:@{} success:^(id result) {
        ShowMessage(result);
        [self qiandaoClose];
    } failure:^(NSError *error) {
    }];
}
-(void)hongbaoClick:(UIButton *)sender
{
    SigninChild *model =self.model.additionalSignIn[sender.tag];
    [RequestHelp POST:JS_GETREWARD_URL parameters:@{@"consecutiveDays":model.consecutiveDays} success:^(id result) {
        ShowMessage(result);
        [self qiandaoClose];
    } failure:^(NSError *error) {
    }];
}
-(void)qiandao
{
    ShowMaskStatus(@"加载数据中");
    [RequestHelp POST:JS_SIGNRECORD_URL parameters:@{} success:^(id result) {
        MKLog(@"%@",result);
        DismissHud();
        self.model  =[SignModel yy_modelWithJSON:result];
        [[UIApplication sharedApplication].keyWindow addSubview:self.bgButton];
        self.qView.model =self.model;
        [self.bgButton addSubview:self.qView];
        
    } failure:^(NSError *error) {
        DismissHud();
    }];
}
-(QiandaoView *)qView
{
    if (!_qView) {
        _qView =[[[NSBundle mainBundle] loadNibNamed:@"QiandaoView" owner:self options:nil] firstObject];
        _qView.delegate =self;
        _qView.frame =CGRectMake(0, 0, 280, 386);
        _qView.center =CGPointMake(Screen_Width/2, Screen_Height/2);
    }
    return _qView;
}
-(void)createFamily
{
    //act
    FamilyCreateController * fvc=[FamilyCreateController new];
    fvc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:fvc animated:YES];
}

-(void)requestData
{
    [RequestHelp POST:JS_FAMILY_LIST_URL2 parameters:@{@"pageNum":@"1",@"pageRow":@"999",@"id":@""} success:^(id result) {
        MKLog(@"%@",result);
        [self.dataAry addObjectsFromArray:[NSArray yy_modelArrayWithClass:[FamilyListModel class] json:result[@"list"]]];
        
        if (self.dataAry.count)
        {
            for (int i=0; i<self.dataAry.count; i++)
            {
                FamilyListModel * model =self.dataAry[i];
                QPointAnnotation *pointAnnotation = [[QPointAnnotation alloc] init];
                CLLocationCoordinate2D point = (CLLocationCoordinate2D){[model.lat floatValue],[model.lon floatValue]};
                [self.nameAry addObject:model.name];
                pointAnnotation.coordinate = point;
                // 点标注的标题
                pointAnnotation.title = model.name;
                // 副标题
                pointAnnotation.subtitle = model.introduce;
                // 将点标记添加到地图中
                [self.mapView addAnnotation:pointAnnotation];
                if (i==0)
                {
                    [self.mapView setCenterCoordinate:point];
                }
            }
        }
        else
        {
            ShowMessage(@"未搜索到相应家族");
        }
    } failure:^(NSError *error) {
        
    }];
}
-(NSMutableArray *)nameAry
{
    if (!_nameAry) {
        _nameAry =[NSMutableArray array];
    }
    return _nameAry;
}
-(void)setUICompoents
{
    UIView * topView =[[UIView alloc]initWithFrame:CGRectMake(0, K_NaviHeight, Screen_Width, 50)];
    topView.backgroundColor =[UIColor clearColor];
    [self.view addSubview:topView];
    
    UITextField * textf =[[UITextField alloc]initWithFrame:CGRectMake(10, 10, Screen_Width-20, 30)];
    textf.borderStyle=UITextBorderStyleRoundedRect;
    textf.font =MKFont(12);
    textf.delegate =self;
    textf.placeholder =@"🔍请输入要搜索的家族名称";

    [topView addSubview:textf];

    self.mapView = [[QMapView alloc] initWithFrame:CGRectMake(0, K_NaviHeight+50, Screen_Width, Screen_Height-K_NaviHeight-50)];
    //接受地图的delegate回调
    self.mapView.delegate = self;
    [self.mapView setShowsUserLocation:YES];
    [self.mapView setUserTrackingMode:QUserTrackingModeFollow];
    //把mapView添加到view中进行显示
    [self.view addSubview:self.mapView];
    
//    QPointAnnotation *pointAnnotation = [[QPointAnnotation alloc] init];
//    pointAnnotation.coordinate = CLLocationCoordinate2DMake(40.040219, 116.273348);
//    // 点标注的标题
//    pointAnnotation.title = @"张氏家族";
//    // 副标题
//    pointAnnotation.subtitle = @"第一家族";
//
//    // 将点标记添加到地图中
//    [self.mapView addAnnotation:pointAnnotation];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    if (textField.text.length)
    {
        [RequestHelp POST:JS_FAMILY_LIST_URL2 parameters:@{@"name":textField.text,@"pageNum":@"1",@"pageRow":@"10",@"id":@""} success:^(id result) {
            MKLog(@"%@",result);
            [self.dataAry addObjectsFromArray:[NSArray yy_modelArrayWithClass:[FamilyListModel class] json:result[@"list"]]];
            
            
            if (self.dataAry.count)
            {
                for (int i=0; i<self.dataAry.count; i++)
                {
                    FamilyListModel * model =self.dataAry[i];
                        QPointAnnotation *pointAnnotation = [[QPointAnnotation alloc] init];
                        CLLocationCoordinate2D point = (CLLocationCoordinate2D){[model.lat floatValue],[model.lon floatValue]};
                    [self.nameAry addObject:model.name];
                    pointAnnotation.coordinate = point;
                        // 点标注的标题
                    pointAnnotation.title = model.name;
                        // 副标题
                    pointAnnotation.subtitle = model.introduce;
                        // 将点标记添加到地图中
                    [self.mapView addAnnotation:pointAnnotation];
                    if (i==0)
                    {
                        [self.mapView setCenterCoordinate:point];
                    }
                }
            }
            else
            {
                ShowMessage(@"未搜索到相应家族");
            }
        } failure:^(NSError *error) {
            
        }];
    }
    return YES;
}


- (QAnnotationView *)mapView:(QMapView *)mapView viewForAnnotation:(id<QAnnotation>)annotation {
    if ([annotation isKindOfClass:[QPointAnnotation class]]) {
        static NSString *annotationIdentifier = @"pointAnnotation";
        QPinAnnotationView *pinView = (QPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
        pinView.enabled =YES;
        if (pinView == nil) {
            pinView = [[QPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
            pinView.canShowCallout = YES;
            pinView.selected=YES;
            pinView.enabled =YES;
            pinView.image =KImageNamed(@"dingwei");
        }
        
        return pinView;
    }
    
    return nil;
}

- (void)mapView:(QMapView *)mapView didSelectAnnotationView:(QAnnotationView *)view
{
    NSInteger index =[self.nameAry indexOfObject:view.annotation.title];
    
    FamilyListModel * model =self.dataAry[index];
    
    FamilyDescController * fvc =[FamilyDescController new];
    fvc.hidesBottomBarWhenPushed=YES;
    fvc.model=model;
    [self.navigationController pushViewController:fvc animated:YES];
    
    MKLog(@"!");
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}
@end
