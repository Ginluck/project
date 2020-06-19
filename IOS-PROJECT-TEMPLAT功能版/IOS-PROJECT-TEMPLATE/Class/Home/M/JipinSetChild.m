//
//  JipinSetChild.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/6/2.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "JipinSetChild.h"

@implementation JipinSetChild
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"xiangList" : [GongFengListModel class],@"laList":[GongFengListModel class],@"qitaList":[GongFengListModel class]};
}
@end
