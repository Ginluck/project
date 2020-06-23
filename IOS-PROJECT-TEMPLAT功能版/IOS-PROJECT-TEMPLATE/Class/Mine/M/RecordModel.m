//
//  RecordModel.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/6/23.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "RecordModel.h"

@implementation RecordModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [RecordChild class]};
}
@end
