//
//  JipinSetModel.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/6/2.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "JipinSetModel.h"

@implementation JipinSetModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"second" : [GongFengListModel class],@"third":[GongFengListModel class]};
}
@end
