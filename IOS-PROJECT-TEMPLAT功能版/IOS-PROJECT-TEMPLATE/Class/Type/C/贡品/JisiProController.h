//
//  JisiProController.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/12.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "TPBaseViewController.h"
#import "DLTabedSlideView.h"
#import "CitangListModel.h"
#import "JipinModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^SelectedIteBlock)(JipinChild *model);
@interface JisiProController : TPBaseViewController
@property (weak, nonatomic) IBOutlet DLTabedSlideView *tabedSlideView;
@property(assign,nonatomic)NSInteger selectedIndex;
@property(strong,nonatomic)CitangListModel* model;
@property (nonatomic, copy) SelectedIteBlock block;
@end

NS_ASSUME_NONNULL_END
