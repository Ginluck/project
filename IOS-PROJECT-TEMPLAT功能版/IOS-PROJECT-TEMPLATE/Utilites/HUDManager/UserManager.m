//
//  UserManager.m
//  XinJiangTaxiProject
//
//  Created by apple on 2017/7/10.
//  Copyright © 2017年 HeXiulian. All rights reserved.
//

#import "UserManager.h"
#import "UserModel.h"


@implementation UserManager
static id instance = nil;

+ (instancetype)shareInstance{
    
    if (!instance) {
      instance =  [[UserManager alloc]init];
    }
    
    return instance;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    if (!instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [super allocWithZone:zone];
        });
    }
    return instance;
}

#pragma mark - user

- (void)saveUser:(UserModel *)user{
    
    MKLog(@"%@",kUserPath);
    UserModel *user1 = [self getUser];
    if ([user1.id isEqualToString:user.id]) {
        user1.userName = user.userName;
    }
    
    if (user) {
        [NSKeyedArchiver archiveRootObject:user toFile:kUserPath];
        [self saveUserId:user.id];
    }else{
        
        [self removeUser];
    }
}


- (void)removeUserId{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:kUserIdKey];
    [defaults synchronize];
}


- (UserModel *)getUser{
    UserModel *user = [NSKeyedUnarchiver unarchiveObjectWithFile:kUserPath];

    return user;
}

- (void)removeUser{
    NSError *error = nil;
    [[NSFileManager defaultManager] removeItemAtPath:kUserPath error:&error];
    
    if (error) {
        MKLog(@"%@",error.description);
    }
}

- (NSString *)getUserId{
    
    return [[NSUserDefaults standardUserDefaults] stringForKey:kUserIdKey];
}

-(void)removeToken
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kTOKEN"];
}
- (void)saveUserId:(NSString *)userId{
    if (userId != nil) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:userId forKey:kUserIdKey];
        [defaults synchronize];
    }else{
        [self removeUserId];
    }
}










///token
- (void)saveToken:(NSString *)token{
    if (token != nil) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:token forKey:@"kTOKEN"];
        [defaults synchronize];
    }else{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:@"kTOKEN"];
        [defaults synchronize];
    }
    
}
- (NSString *)getToken{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"kTOKEN"];
}




@end
