//
//  AddrChooseController.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/19.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "TPBaseViewController.h"
#import <QMapKit/QMapKit.h>
#import <QMapKit/QMSSearchKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef void(^SelectedRoomBlock)(NSObject *model);

@interface AddrChooseController : TPBaseViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *KNavHeight;
@property (weak, nonatomic) IBOutlet UIView *KNavView;
@property (weak, nonatomic) IBOutlet UIView *midView;
@property (nonatomic, copy) SelectedRoomBlock selectedRoomBlock;

@end

NS_ASSUME_NONNULL_END
