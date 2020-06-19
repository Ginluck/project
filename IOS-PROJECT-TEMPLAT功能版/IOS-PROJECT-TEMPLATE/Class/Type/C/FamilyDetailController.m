//
//  FamilyDetailController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/9.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "FamilyDetailController.h"
#import "HomeHeaderView.h"
#import "HomePeopleCollectionViewCell.h"
#import "JYEqualCellSpaceFlowLayout.h"
#import "JisiProController.h"
#import "FamilyTreeController.h"
#import "CitangListModel.h"
#import "WorshipController.h"
#import "FamilyLineController.h"
#import "UILabel+WY_Extension.h"
#import "UITextView+WJPlaceholder.h"
@interface FamilyDetailController ()
<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,HeaderViewDelegate>

@property(nonatomic,strong)UICollectionView *myCollectionView;
@property(nonatomic,strong)NSMutableArray  * dataAry ;
@property(nonatomic,assign)NSInteger  page;
@property(nonatomic,strong)HomeHeaderView *HHView;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UIImageView *backImage;
@property (strong, nonatomic)  UITextView *TxtView;
@end

@implementation FamilyDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitleView:self.model.name];
    [self.view addSubview:self.backImage];
    [self.view addSubview:self.HHView];
    [self.view addSubview:self.bottomView];
    
}

-(UIImageView *)backImage
{
    if (!_backImage) {
        _backImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        _backImage.image =KImageNamed(@"通用背景");
    }
    return _backImage;
}
-(void)headerViewClick:(UIButton *)button
{
    if (button.tag ==10)
    {
        FamilyLineController * fvc =[FamilyLineController new];
        fvc.model=self.model;
        [self.navigationController pushViewController:fvc animated:YES];
    }
    else
    {
        WorshipController * WVC =[WorshipController new];
        CitangListModel  *MOdel =[CitangListModel new];
        MOdel.id =self.model.ctId;
        WVC.model =MOdel;
        [self.navigationController pushViewController:WVC animated:YES];
    }
}

-(HomeHeaderView *)HHView
{
    if (!_HHView) {
        _HHView=[[NSBundle mainBundle]loadNibNamed:@"HomeHeaderView" owner:nil options:nil][0];
        _HHView.frame =CGRectMake(0, kNavagationBarH, Screen_Width, 320);
        [_HHView setArrBanners:@[@""]];
        _HHView.delegate=self;
        _HHView.allLab.text=[NSString stringWithFormat:@"总人口:%@",self.model.jzNum];
        _HHView.zsLab.text=[NSString stringWithFormat:@"在世:%@",self.model.jzZsNum];
        _HHView.lsLab.text=[NSString stringWithFormat:@"离世:%@",self.model.jzLsNum];
        if ([self.model.isAdmin isEqualToString:@"1"]) {
            _HHView.ChageBtn.alpha=1;
        }else
        {
            _HHView.ChageBtn.alpha=0;
        }
        [_HHView.ChageBtn addTarget:self action:@selector(SubmitClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _HHView;
}
-(UIView *)bottomView
{
    if (!_bottomView)
    {
        _bottomView =[[UIView alloc]initWithFrame:CGRectMake(0, 320+kNavagationBarH, Screen_Width, Screen_Height-kNavagationBarH-320-kBottomLayout)];
          _TxtView =[[UITextView alloc]initWithFrame:CGRectMake(10, 10, Screen_Width-20, CGRectGetHeight(_bottomView.frame)-20)];
        _TxtView.textColor =K_PROJECT_GARYTEXTCOLOR;
        _TxtView.text =self.model.introduce;
        _TxtView.placeholder=@"写点什么吧...";
        _TxtView.placeholderColor=[UIColor lightGrayColor];
        _TxtView.backgroundColor =[UIColor clearColor];
        [_bottomView addSubview:_TxtView];
        if ([self.model.isAdmin isEqualToString:@"1"]) {
            _TxtView.selectable=YES;
               }else
               {
                  _TxtView.selectable=NO;
               }
    
    }
    return _bottomView;
}
-(void)SubmitClick
{
    if ([_HHView.ChageBtn.titleLabel.text isEqualToString:@"提交"]) {
        NSString *str = self.TxtView.text;
            str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            self.TxtView.text = str;
            if (str.length < 1 || [str isEqualToString:self.TxtView.placeholder]) {
                ShowErrorStatus(@"请填写简介");
                return;
            }
            WS(weakSelf);
            ShowMaskStatus(@"提交中...");
            [RequestHelp POST:JS_updateJz_URL parameters:@{@"introduce":self.TxtView.text,@"id":self.model.id} success:^(id result) {
                DismissHud();
              ShowMessage(@"提交成功");
          [weakSelf.HHView.ChageBtn setTitle:@"修改" forState:UIControlStateNormal];
            } failure:^(NSError *error) {
                ShowMessage(@"提交失败");
            }];
    }else
    {
        [_HHView.ChageBtn setTitle:@"提交" forState:UIControlStateNormal];
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    //    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

@end
