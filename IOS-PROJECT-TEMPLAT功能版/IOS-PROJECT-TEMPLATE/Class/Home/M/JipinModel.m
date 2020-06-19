//
//  JipinModel.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/25.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "JipinModel.h"

@implementation JipinModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"sacrificeList" : [JipinChild class]};
}
@end
