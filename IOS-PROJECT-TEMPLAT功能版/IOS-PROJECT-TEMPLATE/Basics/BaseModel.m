//
//  BaseModel.m
//  XinJiangTaxiProject
//
//  Created by he on 2017/7/8.
//  Copyright © 2017年 HeXiulian. All rights reserved.
//

#import "BaseModel.h"
#import <YYModel/YYModel.h>
@implementation BaseModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init]; return [self yy_modelInitWithCoder:aDecoder];
}

@end
