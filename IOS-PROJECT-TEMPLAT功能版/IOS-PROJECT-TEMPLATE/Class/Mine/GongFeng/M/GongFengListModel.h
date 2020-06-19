//
//  GongFengListModel.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/6/1.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GongFengListModel : NSObject
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *ctId;
@property(nonatomic,strong)NSString *jpId;
@property(nonatomic,strong)NSString *jpName;
@property(nonatomic,strong)NSString *jpImgUrl;
@property(nonatomic,strong)NSString *jpMoral;
@property(nonatomic,strong)NSString *ctName;

@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *userUserId;
@property(nonatomic,strong)NSString *amountOfMoney;
@property(nonatomic,strong)NSString *beOverdueTime;
@property(nonatomic,strong)NSString *createTime;
@property(nonatomic,strong)NSString *useLength;
@property(nonatomic,strong)NSString *singleLength;



@property(nonatomic,assign)CGFloat position_x;
@property(nonatomic,assign)CGFloat position_y;

@property(nonatomic,assign)CGFloat x_postion;
@property(nonatomic,assign)CGFloat y_postion;

@property(nonatomic,strong)NSString *count;

@end

NS_ASSUME_NONNULL_END
