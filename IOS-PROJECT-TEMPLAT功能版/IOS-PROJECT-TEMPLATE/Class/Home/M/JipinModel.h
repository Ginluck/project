//
//  JipinModel.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/25.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JipinChild.h"
NS_ASSUME_NONNULL_BEGIN

@interface JipinModel : NSObject
@property(nonatomic,strong)NSString * parentId;
@property(nonatomic,strong)NSString * isSetEquity;
@property(nonatomic,strong)NSString * id;
@property(nonatomic,strong)NSString * updated_time;
@property(nonatomic,strong)NSString * delete_status;
@property(nonatomic,strong)NSString * created_time;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSArray <JipinChild *> * sacrificeList;
@end

NS_ASSUME_NONNULL_END
