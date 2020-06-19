//
//  FamilyTreeModel.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/18.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "FamilyTreeModel.h"

@implementation FamilyTreeModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [FamilyTreeMember class]};
}
@end
