//
//  MemberDetailModel.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/27.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "MemberDetailModel.h"

@implementation MemberDetailModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"chirdrenList" : [MemberDetailChild class]};
}
@end
