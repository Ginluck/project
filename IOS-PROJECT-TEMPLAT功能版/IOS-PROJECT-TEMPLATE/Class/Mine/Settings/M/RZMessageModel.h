//
//  RZMessageModel.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/22.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RZMessageModel : BaseModel
@property(nonatomic,strong)NSString * reason;
@property(nonatomic,strong)NSString * rejectReason;
@property(nonatomic,strong)NSString * createTime;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * jzId;
@property(nonatomic,strong)NSString * userUserId;
@property(nonatomic,strong)NSString * updateTime;
@property(nonatomic,strong)NSString * id;
@property(nonatomic,strong)NSString * state;
@property(nonatomic,strong)NSString * zp_id;
@property(nonatomic,strong)NSString * real_name;
@end

NS_ASSUME_NONNULL_END
