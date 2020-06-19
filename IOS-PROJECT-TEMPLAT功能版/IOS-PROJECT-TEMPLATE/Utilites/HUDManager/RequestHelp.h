//
//  RequestHelp.h
//  XinJiangTaxiProject
//
//  Created by apple on 2017/7/4.
//  Copyright © 2017年 HeXiulian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "HUDHelp.h"
#define mUserDefaultsCookie @"mUserDefaultsCookie"
#define kRESPONSE @"RESPONSE"
#define kHEAD @"head"
#define kCODE @"returnCode"
#define kMSG @"returnMsg"
#define kDATE @"date"
#define kBODY @"returnData"


//#import <JSo>

typedef void(^SuccessBlock)(id result);
typedef void(^FailBlock)(NSError *error);

@interface RequestHelp : NSObject

/**
 *[AFNetWorking]的operationManager对象
 */
@property (nonatomic, strong) AFHTTPSessionManager* operationManager;

/**
 *当前的请求operation队列
 */
@property (nonatomic, strong) NSOperationQueue* operationQueue;

+(instancetype)instanceRequestHelp;


/**
 *功能：POST请求
 *参数：(1)请求的url: urlString
 *     (2)POST请求体参数:parameters
 *     (3)请求成功调用的Block: success
 *     (4)请求失败调用的Block: failure
 */
+(void)POST:(NSString *)URLString
 parameters:(NSDictionary*)parameters
    success:(SuccessBlock)success
    failure:(FailBlock)failure;

/**
 功能：POST请求(注册专用||密码登录）

 @param URLString url
 @param parameters 参数
 @param dateString 日期
 @param success 成功回调
 @param failure 失败回调
 */
+(void)POSTRegister:(NSString *)URLString
         parameters:(NSDictionary*)parameters
   headerDateString:(NSString *)dateString
    success:(SuccessBlock)success
    failure:(FailBlock)failure;


/**
 上传图片信息
 
 @param photoData 图片data
 
 */
+ (void)uploadPhotoData:(NSData *)photoData
                success:(SuccessBlock)success
                failure:(FailBlock)failure;


/**
 *取消当前请求队列的所有请求
 */
-(void)cancelAllOperations;

/**
 网络状态判断
 */
+ (void)addReachabilityNetworkBackHandle:(void(^)())handler;


/**
 下载图形验证码

 @param url <#url description#>
 @param param <#param description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+ (void)downViImageCodeWithUrl:(NSString *)url
                        params:(id)param
                       success:(SuccessBlock)success
                       failure:(FailBlock)failure;


+ (void)GETWeChatWithURL:(NSString *)url
                 success:(SuccessBlock)success
                 failure:(FailBlock)failure;

+(void)POSTUpdate:(NSString *)URLString parameters:(NSDictionary *)parameters success:(SuccessBlock)success failure:(FailBlock)failure;

@end
