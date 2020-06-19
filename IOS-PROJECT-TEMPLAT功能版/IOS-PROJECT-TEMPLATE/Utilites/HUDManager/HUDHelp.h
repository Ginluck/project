//
//  HUDHelp.h
//  FWRACProject
//
//  Created by he on 2017/2/24.
//  Copyright © 2017年 he. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface HUDHelp : NSObject



/*
 成功状态说明
 */
extern void ShowSuccessStatus(NSString *statues);
/*
 错误状态说明
 */
extern void ShowErrorStatus(NSString *statues);
/*
 任务状态说明
 */
extern void ShowMaskStatus(NSString *statues);
/*
 状态说明
 */
extern void ShowMessage(NSString *statues);
/*
 进度状态说明
 */
extern void ShowProgress(CGFloat progress);
/*
 hud隐藏
 */
extern void DismissHud(void);

@end
