//
//  RecordModel.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/6/23.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecordChild.h"
NS_ASSUME_NONNULL_BEGIN

@interface RecordModel : NSObject

@property(nonatomic,strong)NSString *     totalCurrency;
@property(nonatomic,strong)NSArray<RecordChild *> * list;
@end

NS_ASSUME_NONNULL_END
