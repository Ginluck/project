//
//  MemberDetailModel.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/27.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MemberDetailChild.h"

NS_ASSUME_NONNULL_BEGIN

@interface MemberDetailModel : NSObject
@property(nonatomic,strong)NSString * userUserId;
@property(nonatomic,strong)NSString * parentName;
@property(nonatomic,strong)NSString * userPhone;
@property(nonatomic,strong)NSString * deleteStatus;
@property(nonatomic,strong)NSString * spouseName;
@property(nonatomic,strong)NSString * updateTime;
@property(nonatomic,strong)NSString * sex;
@property(nonatomic,strong)NSString * parentHeadAddress;
@property(nonatomic,strong)NSString * birthTime;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * parentIntroduce;
@property(nonatomic,strong)NSString * patriarch;
@property(nonatomic,strong)NSString * state;
@property(nonatomic,strong)NSString * jzName;
@property(nonatomic,strong)NSString * id;
@property(nonatomic,strong)NSString * spouseUserPhone;
@property(nonatomic,strong)NSString * jzId;
@property(nonatomic,strong)NSString * spouseHeadAddress;
@property(nonatomic,strong)NSString * spouseId;
@property(nonatomic,strong)NSString * headAddress;
@property(nonatomic,strong)NSString * parentId;
@property(nonatomic,strong)NSString * parentUserPhone;
@property(nonatomic,strong)NSString * deathTime;
@property(nonatomic,strong)NSString * spouseState;
@property(nonatomic,strong)NSString * spouseIntroduce;
@property(nonatomic,strong)NSString * introduce;
@property(nonatomic,strong)NSArray <MemberDetailChild *>*chirdrenList;
@property(nonatomic,strong)NSArray <NSArray *>*homeList;
@end

NS_ASSUME_NONNULL_END
