//
//  ShopPopView.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/11.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "ShopPopView.h"

@implementation ShopPopView
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self GuigeBtn:@[@"1",@"2",@"3"]];
    [self YangShiBtn:@[@"1",@"2",@"3"]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weixinTextFieldTextChanged) name:UITextFieldTextDidChangeNotification object:nil];
 
}
-(void)weixinTextFieldTextChanged {
 if ([self.NumTF isFirstResponder]) {
 if (self.NumTF.text.length >= 2) {
NSMutableString *mutStr = [NSMutableString stringWithString:self.NumTF.text];
NSString *str = [mutStr substringToIndex:2];
     NSString *first = [self.NumTF.text substringToIndex:1];//字符串开始
     if ([first isEqualToString:@"0"]) {
            NSString *last = [self.NumTF.text substringFromIndex:self.NumTF.text.length-1];
         self.NumTF.text = last;
         }else
         {
             self.NumTF.text = str;
         }
 }
     if ([self.NumTF.text isEqualToString:@""]) {
         self.NumTF.text=@"1";
     }
 
 }
 
    
}
- (void)dealloc

{

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];

}
-(void)GuigeBtn:(NSArray *)arr
{
//     for (UIView *view in self.GuiGeView.subviews) {
//            [view removeFromSuperview];
//        }

        CGFloat marginX = 15;
        CGFloat marginY = 1;
        CGFloat height = 30;
        UIButton * markBtn;
        for (int i = 0; i < arr.count; i++) {
            
            CGFloat width =  [self calculateString:arr[i] Width:12] +15;
            UIButton * tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            if (!markBtn) {
                tagBtn.frame = CGRectMake(0, 1, width, height);
            }else{
                if (markBtn.frame.origin.x + markBtn.frame.size.width + marginX + width + marginX > Screen_Width-32) {
                    tagBtn.frame = CGRectMake(0, markBtn.frame.origin.y + markBtn.frame.size.height + marginY, width, height);
                }else{
                    tagBtn.frame = CGRectMake(markBtn.frame.origin.x + markBtn.frame.size.width + marginX, markBtn.frame.origin.y, width, height);
                }
            }
            
            [tagBtn setTitle:arr[i] forState:UIControlStateNormal];
            tagBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            [tagBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self makeCornerRadius:4 borderColor:DIVIDELINECOLOR layer:tagBtn.layer borderWidth:1];
            markBtn = tagBtn;
  
            
            [self.GuiGeView addSubview:markBtn];
            markBtn.tag=10000+i;
            [markBtn addTarget:self action:@selector(GuiGeClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        CGRect rect = self.frame;
        rect.size.height = markBtn.frame.origin.y + markBtn.frame.size.height + marginY;
        
        self.frame = rect;
      
  

}
-(void)YangShiBtn:(NSArray *)arr
{
//     for (UIView *view in self.YangShiView.subviews) {
//            [view removeFromSuperview];
//        }

        CGFloat marginX = 15;
        CGFloat marginY = 1;
        CGFloat height = 30;
        UIButton * markBtn;
        for (int i = 0; i < arr.count; i++) {
            
            CGFloat width =  [self calculateString:arr[i] Width:12] +15;
            UIButton * tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            if (!markBtn) {
                tagBtn.frame = CGRectMake(0, 1, width, height);
            }else{
                if (markBtn.frame.origin.x + markBtn.frame.size.width + marginX + width + marginX > Screen_Width-32) {
                    tagBtn.frame = CGRectMake(0, markBtn.frame.origin.y + markBtn.frame.size.height + marginY, width, height);
                }else{
                    tagBtn.frame = CGRectMake(markBtn.frame.origin.x + markBtn.frame.size.width + marginX, markBtn.frame.origin.y, width, height);
                }
            }
            
            [tagBtn setTitle:arr[i] forState:UIControlStateNormal];
            tagBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            [tagBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self makeCornerRadius:4 borderColor:DIVIDELINECOLOR layer:tagBtn.layer borderWidth:1];
            markBtn = tagBtn;
  
            
            [self.YangShiView addSubview:markBtn];
            markBtn.tag=20000+i;
            [markBtn addTarget:self action:@selector(YangShiClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        CGRect rect = self.frame;
        rect.size.height = markBtn.frame.origin.y + markBtn.frame.size.height + marginY;
        
        self.frame = rect;
      
  

}
- (IBAction)Click:(id)sender {
    
    if ([self.NumTF.text floatValue] > 1)
    {
        self.NumTF.text = [NSString stringWithFormat:@"%d",[self.NumTF.text intValue] - 1];
    }
}
- (IBAction)AddClick:(id)sender {
    if ([self.NumTF.text floatValue] < 99)
    {
        self.NumTF.text = [NSString stringWithFormat:@"%d",[self.NumTF.text intValue] + 1];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.NumTF.text floatValue] < 1 ||[self.NumTF.text floatValue] > 100)
    {
        return;
    }
}
-(CGFloat)calculateString:(NSString *)str Width:(NSInteger)font
{
    CGSize size = [str boundingRectWithSize:CGSizeMake(Screen_Width-32, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil].size;
    return size.width;
}
-(void)makeCornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor layer:(CALayer *)layer borderWidth:(CGFloat)borderWidth
{
    layer.cornerRadius = radius;
    layer.masksToBounds = YES;
    layer.borderColor = borderColor.CGColor;
    layer.borderWidth = borderWidth;
}
-(void)GuiGeClick:(UIButton *)btn
{
    for (UIButton *bbtn in self.GuiGeView.subviews) {
        if (btn.tag==bbtn.tag) {
            [self makeCornerRadius:4 borderColor:[UIColor redColor] layer:btn.layer borderWidth:1];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }else
        {
            [bbtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self makeCornerRadius:4 borderColor:DIVIDELINECOLOR layer:bbtn.layer borderWidth:1];
        }
    }
    
}
-(void)YangShiClick:(UIButton *)btn
{
    for (UIButton *bbtn in self.YangShiView.subviews) {
        if (btn.tag==bbtn.tag) {
            [self makeCornerRadius:4 borderColor:[UIColor redColor] layer:btn.layer borderWidth:1];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }else
        {
            [bbtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self makeCornerRadius:4 borderColor:DIVIDELINECOLOR layer:bbtn.layer borderWidth:1];
        }
    }
    
}
@end
