//
//  HUDHelp.m
//  FWRACProject
//
//  Created by he on 2017/2/24.
//  Copyright © 2017年 he. All rights reserved.
//

#import "HUDHelp.h"
#import <SVProgressHUD.h>

@implementation HUDHelp
+ (void)load
{
    [SVProgressHUD setBackgroundColor:COLOR(0, 0, 0, 0.8)];
    
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    
    [SVProgressHUD setInfoImage:KImageNamed(@"")];
}

void ShowSuccessStatus(NSString *statues)
{
    if (![NSThread isMainThread])
    {
        dispatch_async(dispatch_get_main_queue(),
        ^{
            [SVProgressHUD showSuccessWithStatus:statues];
        });
    }
    else
    {
        [SVProgressHUD showSuccessWithStatus:statues];
    }
}


void ShowMessage(NSString *statues)
{
    if (![NSThread isMainThread])
    {
        dispatch_async(dispatch_get_main_queue(),
       ^{
            [SVProgressHUD showInfoWithStatus:statues];
        });
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:statues];
    }
}

void ShowErrorStatus(NSString *statues)
{
    if (![NSThread isMainThread])
    {
        dispatch_async(dispatch_get_main_queue(),
        ^{
            [SVProgressHUD showErrorWithStatus:statues];
            
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
            
            [SVProgressHUD showProgress:0.5 status:@"上传"];
        });
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:statues];
    }
}


void ShowMaskStatus(NSString *statues)
{
    if (![NSThread isMainThread])
    {
        dispatch_async(dispatch_get_main_queue(),
        ^{
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
            
            [SVProgressHUD showWithStatus:statues];
        });
    }
    else
    {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        
        [SVProgressHUD showWithStatus:statues];
    }
}

void ShowProgress(CGFloat progress)
{
    if (![NSThread isMainThread])
    {
        dispatch_async(dispatch_get_main_queue(),
        ^{
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
            
            [SVProgressHUD showProgress:progress];
        });
    }
    else
    {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        
        [SVProgressHUD showProgress:progress];
    }
}

void DismissHud(void)
{
    if (![NSThread isMainThread])
    {
        dispatch_async(dispatch_get_main_queue(),
        ^{
            [SVProgressHUD dismiss];
        });
    }
    else
    {
        [SVProgressHUD dismiss];
    }
}

@end
