//
//  UserManager.h
//  XinJiangTaxiProject
//
//  Created by apple on 2017/7/10.
//  Copyright © 2017年 HeXiulian. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserModel;
@class CityModel;

//Documents目录路径
#define kSandBoxDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//用户对象归档路径
#define kUserPath [kSandBoxDocumentPath stringByAppendingPathComponent:@"user"]
//用户对象归档路径
#define kCityPath [kSandBoxDocumentPath stringByAppendingPathComponent:@"city"]




//存储sessionId的key
#define kUserIdKey @"userIdKey"
#define kCityIdKey @"cityIdKey"
#define kCurrentCityIdKey @"currentCityIdKey"


#define kUserPasswordKey @"pwdKey"
#define kUserEntryPassword @"EntryPassword"
#define kUserNameKey @"UserNameKey"

#define kComparyPasswordKey @"ComparypwdKey"
#define kComparyEntryPassword @"ComparyEntryPassword"
#define kComparyNameKey @"ComparyNameKey"

@interface UserManager : NSObject

+ (instancetype)shareInstance;

//用户
- (void)saveUser:(UserModel *)user;
- (UserModel *)getUser;
- (NSString *)getUserId;
- (void)removeUser;
//当前选择的城市
//- (void)saveCity:(CityModel *)city;
//- (CityModel *)getCity;
//- (NSString *)getCityId;

//- (void)saveCurrentCity:(NSString *)currentCity;
//- (NSString *)getCurrentCity;
//-(void)removeUserId;
//- (void)saveUserLocation:(CLLocationCoordinate2D)userLocation;
//- (CLLocationCoordinate2D)getUserLocation;
///token
-(void)removeUserId;
- (void)saveToken:(NSString *)token;
- (NSString *)getToken;
-(void)removeToken;

@end
