//
//  FamilyTreeMember.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/18.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FamilyTreeMember : NSObject
@property(nonatomic,strong)NSString * birthTime;
@property(nonatomic,strong)NSString * createTime;
@property(nonatomic,strong)NSString * deathTime;
@property(nonatomic,strong)NSString * deleteStatus;
@property(nonatomic,strong)NSString * id;
@property(nonatomic,strong)NSString * jzId;
@property(nonatomic,strong)NSString * jzName;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * parentId;
@property(nonatomic,strong)NSString * patriarch;
@property(nonatomic,strong)NSString * sex;
@property(nonatomic,strong)NSString * spouseId;
@property(nonatomic,strong)NSString * spouseState;
@property(nonatomic,strong)NSString * state;
@property(nonatomic,strong)NSString * updateTime;
@property(nonatomic,strong)NSString * userUserId;
@property(nonatomic,strong)NSString * headAddress;
@property(nonatomic,strong)NSString * userPhone;
@property(nonatomic,strong)NSString * isDelete;
@property(nonatomic,strong)NSString * isSelected;
@property(nonatomic,strong)NSString * count;
@property(nonatomic,strong)NSString * introduce;

@property(nonatomic,assign)NSInteger  parentIndex;
@property(nonatomic,assign)NSInteger  parentSize;
@property(nonatomic,assign)CGFloat  bottom_x;
@property(nonatomic,assign)CGFloat  bottom_y;

@end

NS_ASSUME_NONNULL_END
