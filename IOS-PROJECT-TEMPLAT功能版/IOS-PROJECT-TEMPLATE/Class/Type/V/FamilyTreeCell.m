//
//  FamilyTreeCell.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/7.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "FamilyTreeCell.h"

@implementation FamilyTreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setCell:(NSArray *)ary index:(NSInteger)row
{
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat width =70;
    CGFloat height=40;
    if (ary.count ==1)
    {
        FamilyTreeMember * model =ary[0];
        FamliyTreeButton * button =[FamliyTreeButton buttonWithType:UIButtonTypeCustom];
        button.frame =CGRectMake(0, 0, width+40, height);
        button.center =CGPointMake(Screen_Width/2, 40);
        [button setNormalTitle:model.name font:MKFont(12) titleColor:K_Prokect_MainColor];
        if ([model.isSelected isEqualToString:@"1"]) {
               button.layer.borderColor  =[UIColor blueColor].CGColor;
        }
        else
        {
            button.layer.borderColor  =K_Prokect_MainColor.CGColor;
        }
        button.layer.borderWidth=1.f;
        button.layer.cornerRadius=5.f;
        button.titleLabel.textAlignment=NSTextAlignmentCenter;
        button.layer.masksToBounds=YES;
        button.tag =0;
         button.row =row;
        [button addTarget:self action:@selector(buttonCLick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
    }
    else if(ary.count >1 && ary.count <5)
    {
        CGFloat margin=(Screen_Width -ary.count*width)/(ary.count +1);
        for (int i=0; i<ary.count; i++)
        {
            FamilyTreeMember * model =ary[i];
            FamliyTreeButton * button =[FamliyTreeButton buttonWithType:UIButtonTypeCustom];
            button.frame =CGRectMake(margin+(margin +width)*i, 20, width, height);
            [button setNormalTitle:model.name font:MKFont(12) titleColor:K_Prokect_MainColor];
            if ([model.isSelected isEqualToString:@"1"]) {
                button.layer.borderColor  =[UIColor blueColor].CGColor;
            }
            else
            {
                button.layer.borderColor  =K_Prokect_MainColor.CGColor;
            }
            button.layer.borderWidth=1.f;
            button.layer.cornerRadius=5.f;
            button.tag=i;
            button.row =row;
            button.layer.masksToBounds=YES;
            [button addTarget:self action:@selector(buttonCLick:) forControlEvents:UIControlEventTouchUpInside];

            [self.contentView addSubview:button];
        }
    }
    else
    {
         CGFloat margin=(Screen_Width -4*width)/(ary.count +1);
        UIScrollView * scroll =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 80)];
        scroll.contentSize =CGSizeMake(Screen_Width+(ary.count-4)*(70+margin)+20, 0);
        scroll.contentOffset =CGPointMake(0, 0);
        scroll.showsHorizontalScrollIndicator=NO;
        [self.contentView addSubview:scroll];
        
        for (int i=0; i<ary.count; i++)
        {
             FamilyTreeMember * model =ary[i];
            FamliyTreeButton * button =[FamliyTreeButton buttonWithType:UIButtonTypeCustom];
            button.frame =CGRectMake(margin+(margin +width)*i, 20, width, height);
            [button setNormalTitle:model.name font:MKFont(12) titleColor:K_Prokect_MainColor];
            if ([model.isSelected isEqualToString:@"1"]) {
                button.layer.borderColor  =[UIColor blueColor].CGColor;
            }
            else
            {
                button.layer.borderColor  =K_Prokect_MainColor.CGColor;
            }
            button.layer.borderWidth=1.f;
            button.layer.cornerRadius=5.f;
            button.layer.masksToBounds=YES;
            [button addTarget:self action:@selector(buttonCLick:) forControlEvents:UIControlEventTouchUpInside];
             button.tag=i;
             button.row =row;
            [scroll addSubview:button];
        }
        
        
        
    }
}
-(void)buttonCLick:(FamliyTreeButton * )button
{
    if (self.delegate) {
        [self.delegate  familyBtnClick:button];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
@implementation FamliyTreeButton

@synthesize row;

@end
