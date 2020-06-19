//
//  ViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2019/7/2.
//  Copyright © 2019年 梦境网络. All rights reserved.
//

#import "ViewController.h"
#import "NSDate+CommonDate.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView * imageV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    

    
   NSUInteger value= [[NSDate date]getMonth];
    NSString * str =[NSString stringWithFormat:@"启动页面%lu",(unsigned long)value];
    imageV.image =KImageNamed(str);
    [self.view addSubview:imageV];
    // Do any additional setup after loading the view, typically from a nib.
}


@end
