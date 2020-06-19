//
//  UserModel.h
//  XinJiangTaxiProject
//
//  Created by apple on 2017/7/10.
//  Copyright © 2017年 HeXiulian. All rights reserved.
//

#import "BaseModel.h"

@interface UserModel : BaseModel

//用户ID
@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *userPhone;
///登录用户名
@property (nonatomic, copy) NSString *realName;

@property (nonatomic, copy) NSString *password;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *updateTime;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *deleteStatus;

@property (nonatomic, copy) NSString *token;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *headAddress;

@property (nonatomic, copy) NSString *ringLetterId;

@property (nonatomic, copy) NSString *shopName;

@property (nonatomic, copy) NSString *wxId;

@property (nonatomic, copy) NSString *qqId;

@property (nonatomic, copy) NSString *aeskey;

@property (nonatomic, copy) NSString *idnumber;

@property (nonatomic, copy) NSString *jzId;

@property (nonatomic, copy) NSString *jzName;


@property (nonatomic, copy) NSString *messageTime;

@property (nonatomic, copy) NSString *lastMessage;

@property (nonatomic, copy) NSString *isRead;

@property(nonatomic,copy)NSString *patriarch;

@property(nonatomic,copy)NSString *introduce;

@end
