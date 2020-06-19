//
//  JipinSetChild.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/6/2.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GongFengListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JipinSetChild : NSObject
@property(nonatomic,strong)NSArray <GongFengListModel *>*xiangList;
@property(nonatomic,strong)NSArray <GongFengListModel *>*qitaList;
@property(nonatomic,strong)NSArray <GongFengListModel *>*laList;
@end

NS_ASSUME_NONNULL_END
