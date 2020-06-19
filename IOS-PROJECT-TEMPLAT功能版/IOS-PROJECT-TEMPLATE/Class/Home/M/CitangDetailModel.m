//
//  CitangDetailModel.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/29.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "CitangDetailModel.h"

@implementation CitangDetailModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"zpList" : [FamilyTreeMember class],@"zpList2":[FamilyTreeModel class]};
}
@end
