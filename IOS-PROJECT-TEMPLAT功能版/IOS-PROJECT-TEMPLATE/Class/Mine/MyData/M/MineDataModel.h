//
//  MineDataModel.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/21.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineDataModel : BaseModel
@property (nonatomic , strong)NSString *headAddress;
@property (nonatomic , strong)NSString *userPhone;
@property (nonatomic , strong)NSString *realName;
@property (nonatomic , strong)NSString *address;
@property (nonatomic , strong)NSString *introduce;
@property (nonatomic , strong)NSString *aeskey;
@property (nonatomic , strong)NSString *createTime;
@property (nonatomic , strong)NSString *deleteStatus;
@property (nonatomic , strong)NSString *email;
@property (nonatomic , strong)NSString *gold;
@end

NS_ASSUME_NONNULL_END
