//
//  JipinCell.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/12.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "JipinCell.h"
#import "JipinView.h"
@implementation JipinCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor =K_Prokect_MainColor;
}

-(void)setCell:(NSArray *)list row:(NSInteger)row
{
    for (UIView * view  in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    UIScrollView * scroll =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Width/4+35)];
    scroll.contentSize =CGSizeMake(Screen_Width/4*list.count+20, 0);
    scroll.contentOffset =CGPointMake(0, 0);
    scroll.showsHorizontalScrollIndicator=NO;
    [self.contentView addSubview:scroll];
    

    
//    UIImageView * image =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width/4*list.count+20,  Screen_Width/4+35)];
//    image.image =KImageNamed(@"木材");
//    [scroll addSubview:image];
    
    for (int i=0; i<list.count; i++)
    {
        JipinChild * child =list[i];
        JipinView * jipin =[[JipinView alloc]initWithFrame:CGRectMake(i*Screen_Width/4, 0, Screen_Width/4, Screen_Width/4+35)];
        jipin.clickBtn.row =row;
        jipin.clickBtn.tag =i;
        [jipin.proImage sd_setImageWithURL:[NSURL URLWithString:child.imgUrl]];
        jipin.topLab.text =child.name;
        jipin.bottomLab.text =child.price;
        [jipin.clickBtn addTarget:self action:@selector(jpClick:) forControlEvents:UIControlEventTouchUpInside];
         [scroll addSubview:jipin];
    }
}


-(void)jpClick:(JPButton*)btn
{
    if (self.delegate) {
        [self.delegate JPCellClick:btn];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
