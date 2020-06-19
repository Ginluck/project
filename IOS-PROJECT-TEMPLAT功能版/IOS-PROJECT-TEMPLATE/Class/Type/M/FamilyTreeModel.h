//
//  FamilyTreeModel.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/18.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FamilyTreeMember.h"
NS_ASSUME_NONNULL_BEGIN

@interface FamilyTreeModel : NSObject
@property(nonatomic,strong)NSString *count;
@property(nonatomic,strong)NSArray <FamilyTreeMember *>*list;
@property(nonatomic,strong)NSString * lisCount;
@end

NS_ASSUME_NONNULL_END
