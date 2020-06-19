//
//  SignModel.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/6/18.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SigninChild.h"
NS_ASSUME_NONNULL_BEGIN

@interface SignModel : NSObject
@property(nonatomic,strong)NSString * anniversaryMoney;
@property(nonatomic,strong)NSString * signInCount;
@property(nonatomic,strong)NSArray <NSString *>* signInTimeList;
@property(nonatomic,strong)NSArray <SigninChild *>* additionalSignIn;
@property(nonatomic,strong)NSString * signInType;
@end

NS_ASSUME_NONNULL_END
