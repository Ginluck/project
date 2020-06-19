//
//  JipinSetModel.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/6/2.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GongFengListModel.h"
#import "JipinSetChild.h"
NS_ASSUME_NONNULL_BEGIN

@interface JipinSetModel : NSObject
@property(nonatomic,strong)JipinSetChild * first;
@property(nonatomic,strong)NSArray <GongFengListModel *>*second;
@property(nonatomic,strong)NSArray <GongFengListModel *>*third;
@end

NS_ASSUME_NONNULL_END
