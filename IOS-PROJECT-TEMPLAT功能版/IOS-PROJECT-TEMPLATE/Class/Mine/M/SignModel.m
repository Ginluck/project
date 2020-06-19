//
//  SignModel.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/6/18.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "SignModel.h"

@implementation SignModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"additionalSignIn" : [SigninChild class],@"signInTimeList":[NSString class]};
}
@end
