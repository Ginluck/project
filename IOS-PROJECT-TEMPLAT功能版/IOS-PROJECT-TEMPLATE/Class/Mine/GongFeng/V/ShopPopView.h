//
//  ShopPopView.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/11.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^returnBtnTag)(NSInteger index);
typedef void(^returnBtnTag2)(NSInteger index);
@interface ShopPopView : UIView
@property (weak, nonatomic) IBOutlet UITextField *NumTF;
@property (weak, nonatomic) IBOutlet UIButton *BuyBtn;
@property (weak, nonatomic) IBOutlet UIButton *CloseBtn;
@property (weak, nonatomic) IBOutlet UIView *GuiGeView;
@property (weak, nonatomic) IBOutlet UIView *YangShiView;
@property (strong, nonatomic)returnBtnTag RBTBlock;
@property (strong, nonatomic)returnBtnTag2 RBTBlock2;
@end

NS_ASSUME_NONNULL_END
