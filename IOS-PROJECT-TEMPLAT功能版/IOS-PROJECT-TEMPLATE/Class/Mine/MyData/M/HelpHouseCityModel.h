//
//  HelpHouseCityModel.h
//  RentHouseApp
//
//  Created by Apple on 2019/6/14.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HelpHouseCityModel : BaseModel
@property (nonatomic , copy)NSString *code_a;
@property (nonatomic , copy)NSString *id;
@property (nonatomic , copy)NSString *name;
@property (nonatomic , copy)NSString *code_c;
@property (nonatomic , copy)NSString *code_p;
@property (nonatomic , copy)NSString *isSelect;
@end

NS_ASSUME_NONNULL_END
