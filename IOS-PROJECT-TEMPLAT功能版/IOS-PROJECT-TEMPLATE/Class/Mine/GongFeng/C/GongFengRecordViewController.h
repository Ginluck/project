//
//  GongFengRecordViewController.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/9.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "TPBaseViewController.h"
#import "DLTabedSlideView.h"
NS_ASSUME_NONNULL_BEGIN

@interface GongFengRecordViewController : TPBaseViewController
@property (weak, nonatomic) IBOutlet DLTabedSlideView *tabedSlideView;
@property(assign,nonatomic)NSInteger selectedIndex;
@property(assign,nonatomic)BOOL isConfirm;
@end

NS_ASSUME_NONNULL_END
