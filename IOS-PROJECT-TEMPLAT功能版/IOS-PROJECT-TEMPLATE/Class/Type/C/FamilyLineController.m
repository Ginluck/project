//
//  FamilyLineController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/7.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "FamilyLineController.h"
#import "LineView.h"
#import "RectangleView.h"
#import "FamilyTreeModel.h"
#import "FamilyTreeMember.h"
#import "FamilyTreeController.h"
@interface FamilyLineController ()

@property(nonatomic,strong)UIScrollView  * scView;;


@property(nonatomic,strong)LineView * line;
@property(nonatomic,strong)LineView * line2;
@property(nonatomic,strong)LineView * line3;
@property(nonatomic,strong)LineView * line4;
@property(nonatomic,strong)LineView * line5;
@property(nonatomic,strong)LineView * line6;
@property(nonatomic,strong)UIImageView *backImage;
@end

@implementation FamilyLineController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIView * view in self.scView.subviews)
    {
        [view removeFromSuperview];
    }
    [self refreshPostData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.backImage];
    [self.view addSubview:self.scView];

    [self addNavigationTitleView:@"世系图"];
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake(Screen_Width-50, Screen_Height-K_BottomHeight-85, 30, 30);
    [button setImage:KImageNamed(@"add1") forState:UIControlStateNormal];
    button.layer.cornerRadius =15.f;
    button.layer.masksToBounds=YES;
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
-(void)click
{
    FamilyTreeController * fvc =[FamilyTreeController new];
    fvc.model=self.model;
    [self.navigationController pushViewController:fvc animated:YES];
}

-(void)refreshPostData
{
    
    NSDictionary * param =@{@"jzId":self.model.id,@"spouseId":@"1",@"firstGeneration":@"1"};
    [RequestHelp POST:JS_SELECT_ZPLIST_URL parameters:param success:^(id result) {
        DLog(@"%@",result);
        self.dataAry =[NSArray yy_modelArrayWithClass:[FamilyTreeModel class] json:result];
        if (self.dataAry.count) {
              [self resolveData];
        }
    } failure:^(NSError *error) {
       
    }];
}

-(UIImageView *)backImage
{
    if (!_backImage) {
        _backImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        _backImage.image =KImageNamed(@"通用背景");
    }
    return _backImage;
}
-(void)resolveData
{
    // 第一步 计算每一级的数据
    NSMutableArray * arr =[NSMutableArray arrayWithArray:self.dataAry];
    NSMutableArray * countArr =[NSMutableArray array];
    for (int i=0; i<self.dataAry.count; i++)
    {
        FamilyTreeModel * model =arr[i];
        model.lisCount =[NSString stringWithFormat:@"%lu",(unsigned long)model.list.count];
        [arr replaceObjectAtIndex:i withObject:model];
        [countArr addObject:model.lisCount];
    }
    self.dataAry =arr;
    
    //第二步 找出最大的数值数组
     NSInteger max =[[countArr valueForKeyPath:@"@max.integerValue"] integerValue];

    if ((max *50+(max +1)*20)>Screen_Width)
    {
        self.scView.contentSize=CGSizeMake(max*50+(max+1)*20+30, 0);
//          self.scView.contentSize=CGSizeMake(Screen_Width*5,0);
    }
    
    //第三步  匹配关系
    for (int i=0; i<self.dataAry.count; i++)
    {
        FamilyTreeModel  * model =self.dataAry[i];
        
        FamilyTreeModel * modal;
        
        if (i!=0)
        {
            modal=self.dataAry[i-1];
        }
        for (int j=0; j<[model.lisCount integerValue]; j++)
        {
            FamilyTreeMember * member =(FamilyTreeMember *)model.list[j];
            
            if (modal !=nil)
            {
                for (int k=0; k<modal.list.count; k++)
                {
                    FamilyTreeMember * memb =(FamilyTreeMember *)modal.list[k];
                    
                    if ([memb.id isEqualToString:member.parentId])
                    {
                        member.parentIndex =k;
                        
                        member.parentSize=modal.list.count;
                    }
                }
            }
        }
    }
    
    
    //第四步 画矩形 画线
    for (int i=0; i<self.dataAry.count; i++)
    {
        FamilyTreeModel * model =self.dataAry[i];
        
        for (int k=0; k<model.list.count; k++)
        {
            FamilyTreeMember * member = (FamilyTreeMember *)model.list [k];
            if (model.list.count ==1)
            {
                RectangleView * rec =[[RectangleView alloc]initWithFrame:CGRectMake(Screen_Width/2-25, 22+(16+50)*i, 50, 16) str:member.name];
                member.bottom_x =CGRectGetMidX(rec.frame);
                member.bottom_y =CGRectGetMaxY(rec.frame);
                [self.scView addSubview:rec];
                [self drawLine:i parent:member.parentIndex endX:CGRectGetMidX(rec.frame) endY:CGRectGetMinY(rec.frame)];
            }
            else
            {
                if (model.list.count<5)
                {
                    CGFloat margin =(Screen_Width -50*[model.lisCount integerValue])/([model.lisCount integerValue]+1);
                    RectangleView * rec =[[RectangleView alloc]initWithFrame:CGRectMake(margin+(margin+50)*k, 22+(16+50)*i, 50, 15) str:member.name];
                    member.bottom_x =CGRectGetMidX(rec.frame);
                    member.bottom_y =CGRectGetMaxY(rec.frame);
                    
                    [self.scView addSubview:rec];
                    [self drawLine:i parent:member.parentIndex endX:CGRectGetMidX(rec.frame) endY:CGRectGetMinY(rec.frame)];
                }
                else
                {
                    RectangleView * rec =[[RectangleView alloc]initWithFrame:CGRectMake(20+(20+50)*k, 22+(16+50)*i, 50, 15) str:member.name];
                    member.bottom_x =CGRectGetMidX(rec.frame);
                    member.bottom_y =CGRectGetMaxY(rec.frame);
                    [self.scView addSubview:rec];
                         [self drawLine:i parent:member.parentIndex endX:CGRectGetMidX(rec.frame) endY:CGRectGetMinY(rec.frame)];
                }
            }
        }
    }
}




-(void)drawLine:(NSInteger)rowIndex parent:(NSInteger)parentIndex  endX:(CGFloat)endX endY:(CGFloat)endY
{
    if (rowIndex==0)
    {
        return;
    }
    FamilyTreeModel * model =self.dataAry[rowIndex-1];
    FamilyTreeMember * member = (FamilyTreeMember*)model.list[parentIndex];
    
    CGPoint point1 =CGPointMake(member.bottom_x, member.bottom_y);
    CGPoint point2 =CGPointMake(endX, endY);
    
    _line2 = [[LineView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width*10, Screen_Height) point1:point1 point2:point2] ;
    _line2.backgroundColor = [UIColor clearColor];
    
    [self.scView addSubview:_line2];
    
}

-(UIScrollView*)scView
{
    if (!_scView)
    {
        _scView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, K_NaviHeight, Screen_Width, Screen_Height)];
        _scView.backgroundColor =[UIColor clearColor];
    }
    return _scView;
}






@end
