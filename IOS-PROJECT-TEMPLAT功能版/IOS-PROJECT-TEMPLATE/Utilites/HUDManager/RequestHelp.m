//
//  RequestHelp.m
//  XinJiangTaxiProject
//
//  Created by apple on 2017/7/4.
//  Copyright © 2017年 HeXiulian. All rights reserved.
//

#import "RequestHelp.h"
#import "UnitMacro.h"
#import "NSObject+SystemInfo.h"
#import "ViewControllerManager.h"

static RequestHelp *reqHelp =nil;
@implementation RequestHelp

/**
 实例化请求对象
 
 @return 对象
 */
+(instancetype)instanceRequestHelp{
    if (!reqHelp){
        reqHelp =[[RequestHelp alloc]init];
    }
    return  reqHelp;
}

/**
 多线程单例对象创建
 @return 对象
 */
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    if (!reqHelp){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            reqHelp = [super allocWithZone: zone];
            
        });
    }
    return reqHelp;
}

-(AFHTTPSessionManager*)operationManager{
    if (!_operationManager){
        _operationManager = [[AFHTTPSessionManager alloc] init ];//]WithBaseURL:[NSURL URLWithString:SERVER_URL]];
        _operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
        [_operationManager.requestSerializer setValue:@"application/json;charset=UTF-8"forHTTPHeaderField:@"Content-Type"];
        
//        _operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        _operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript",@"text/plain", nil];
        _operationManager.requestSerializer.timeoutInterval = 10;//10s超时

    }
    return _operationManager;
}


/**
 设置请求头

 @param dateString 不为空时（是注册接口）,其他为空
 */
- (void)configHTTPHeader:(NSString *)dateString urlString:(NSString *)URLString{
    //接口名称

    
    NSString *token = [[UserManager shareInstance] getToken];
    
    [self.operationManager.requestSerializer setValue:If_NotData(token, @"") forHTTPHeaderField:@"token"];

    
    NSString *userId = [[UserManager shareInstance] getUserId];
    
    if (!userId) {
        userId = @"";
    }
    
    [self.operationManager.requestSerializer setValue:userId forHTTPHeaderField:@"userId"];
    
     [self.operationManager.requestSerializer setValue:[self getOSType] forHTTPHeaderField:@"ostype"];
    
    [self.operationManager.requestSerializer setValue:[self getAppLoadChannelID] forHTTPHeaderField:@"channelId"];
    
    [self.operationManager.requestSerializer setValue:[self getDeviceUUID] forHTTPHeaderField:@"uuid"];
    
    [self.operationManager.requestSerializer setValue:[self getPhoneType] forHTTPHeaderField:@"deviceType"];
    
//    [self.operationManager.requestSerializer setValue:[self getDevicePixels] forHTTPHeaderField:@"DEVICEPIXELS"];
    
    [self.operationManager.requestSerializer setValue:[self getSystemVersion] forHTTPHeaderField:@"osVersion"];
    
    
    [self.operationManager.requestSerializer setValue:[self getAppVersion] forHTTPHeaderField:@"appVersion"];
    
     [self.operationManager.requestSerializer setValue:@"1" forHTTPHeaderField:@"type"];
    
//    [self.operationManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [self.operationManager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:mUserDefaultsCookie] forHTTPHeaderField:@"jsession"];

    
    if (dateString) {
        
         [self.operationManager.requestSerializer setValue:dateString forHTTPHeaderField:@"date"];
        return;
    }
     [self.operationManager.requestSerializer setValue:[self getSystemDate] forHTTPHeaderField:@"date"];
}

/**
 Post请求
 @param URLString url字符串
 @param parameters 参数字典
 @param success 成功回调代码块
 @param failure 失败回调代码块
 */
+(void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(SuccessBlock)success failure:(FailBlock)failure
{
    if(![self isHasNetWork])
    {
        ShowErrorStatus(@"网络连接错误请检查您的网络！");
        return;
    }
    reqHelp =[RequestHelp instanceRequestHelp];
    
    [reqHelp configHTTPHeader:nil urlString:@""];
   
    NSString * url =[NSString stringWithFormat:@"%@%@",SERVER_URL,URLString];
    if (!parameters) {
        parameters = @{};
    }
    
    NSDictionary *dic = @{@"request":@{@"head":reqHelp.operationManager.requestSerializer.HTTPRequestHeaders ,@"body":parameters}};
    MKLog(@"上行参数：-----\n%@\n",[dic yy_modelToJSONString]);
    [reqHelp.operationManager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        MKLog(@"下行参数：------\n%@\n", [responseObject yy_modelToJSONString]);
        //存储cookie
        NSDictionary *fields = ((NSHTTPURLResponse*)task.response).allHeaderFields;
        
        NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:fields forURL:[NSURL URLWithString:SERVER_URL]];
        
        
        for (NSHTTPCookie *cookie in cookies) {
            
            [[NSUserDefaults standardUserDefaults] setObject:cookie.value forKey:mUserDefaultsCookie];
        }
        
        if (![NSThread isMainThread]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSMutableDictionary *dic = [responseObject mutableCopy];
                if ([dic[kCODE] integerValue] == 100) {
                    success(dic[kBODY]);//成功主线程回掉代码快
                    return ;
                }
                
                if ([dic[kCODE] integerValue] == 1899) {
                    
                    failure(nil);
                    [[UserManager shareInstance] saveToken:nil];
                    [[UserManager shareInstance] saveUser:nil];
                      [[UserManager shareInstance]removeUserId];
                    [ViewControllerManager showLoginViewController];
                    
                    return ;
                }
                
                if ([dic[kCODE] integerValue] == -1){
                    
                    failure(nil);
                    ShowMessage(@"暂时无法购买");
                    return ;
                }
                
                ShowErrorStatus(dic[kMSG]);
                
                failure(nil);
            });
        }else{
            
            NSMutableDictionary *dic = [responseObject mutableCopy];
            if ([dic[kCODE] integerValue] == 100) {
                success(dic[kBODY]);//成功主线程回掉代码快
                return ;
            }
            ShowErrorStatus(dic[kMSG]);
            if ([dic[kCODE] integerValue] == 1899) {
                [[UserManager shareInstance] saveToken:nil];
                [[UserManager shareInstance] saveUser:nil];
                [[UserManager shareInstance]removeUserId];
                failure(nil);
                [ViewControllerManager showLoginViewController];
                
                return ;
            }
            ShowErrorStatus(dic[kMSG]);
            failure(nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DismissHud();
        if (![NSThread isMainThread]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);//成功主线程回掉代码快
             ShowMessage(@"网络异常，请稍后重试");
            });
        }else{
            failure(error);//成功主线程回掉代码快
           ShowMessage(@"网络异常，请稍后重试");
        }
    }];
}
//+(void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(SuccessBlock)success failure:(FailBlock)failure
//{
//    if(![self isHasNetWork])
//    {
//        ShowErrorStatus(@"网络连接错误请检查您的网络！");
//        return;
//    }
//    reqHelp =[RequestHelp instanceRequestHelp];
//
//    [reqHelp configHTTPHeader:nil urlString:URLString];
//    if (!parameters) {
//        parameters = @{};
//    }
//
//    NSDictionary *dic = @{@"REQUEST":@{@"HEAD":reqHelp.operationManager.requestSerializer.HTTPRequestHeaders ,@"BODY":parameters}};
//    MKLog(@"上行参数：-----\n%@\n",[dic yy_modelToJSONString]);
//    [reqHelp.operationManager POST:SERVER_URL parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        MKLog(@"下行参数：------\n%@\n", [responseObject yy_modelToJSONString]);
//        //存储cookie
//        NSDictionary *fields = ((NSHTTPURLResponse*)task.response).allHeaderFields;
//
//        NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:fields forURL:[NSURL URLWithString:SERVER_URL]];
//
//
//        for (NSHTTPCookie *cookie in cookies) {
//
//            [[NSUserDefaults standardUserDefaults] setObject:cookie.value forKey:mUserDefaultsCookie];
//        }
//
//        if (![NSThread isMainThread]) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//
//                NSMutableDictionary *dic = [responseObject mutableCopy];
//                if ([dic[kRESPONSE][kHEAD][kCODE] integerValue] == 1) {
//                    success(dic[kRESPONSE]);//成功主线程回掉代码快
//                    return ;
//                }
//
//                if ([dic[kRESPONSE][kHEAD][kCODE] integerValue] == 1899) {
//
//                    failure(nil);
//                    [[UserManager shareInstance] saveToken:nil];
//                    [[UserManager shareInstance] saveUser:nil];
//
//                    [ViewControllerManager showLoginViewController];
//
//                    return ;
//                }
//
//                ShowErrorStatus(dic[kRESPONSE][kHEAD][kMSG]);
//
//                failure(nil);
//            });
//        }else{
//
//            NSMutableDictionary *dic = [responseObject mutableCopy];
//            if ([dic[kRESPONSE][kHEAD][kCODE] integerValue] == 1) {
//                success(dic[kRESPONSE]);//成功主线程回掉代码快
//                return ;
//            }
//            ShowErrorStatus(dic[kRESPONSE][kHEAD][kMSG]);
//            if ([dic[kRESPONSE][kHEAD][kCODE] integerValue] == 1899) {
//                [[UserManager shareInstance] saveToken:nil];
//                [[UserManager shareInstance] saveUser:nil];
//                failure(nil);
//                [ViewControllerManager showLoginViewController];
//
//                return ;
//            }
//            success(dic[kRESPONSE]);
//            ShowErrorStatus(dic[kRESPONSE][kHEAD][kMSG]);
//            failure(nil);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        DismissHud();
//        if (![NSThread isMainThread]) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                failure(error);//成功主线程回掉代码快
//                 ShowErrorStatus(error.localizedDescription);
//            });
//        }else{
//            failure(error);//成功主线程回掉代码快
//            ShowErrorStatus(error.localizedDescription);
//        }
//    }];
//}

/**
 功能：POST请求(注册专用）
 
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
            failure:(FailBlock)failure{
    
    if(![self isHasNetWork])
    {
        ShowErrorStatus(@"网络连接错误请检查您的网络！");
        return;
    }
    reqHelp =[RequestHelp instanceRequestHelp];
    
    [reqHelp configHTTPHeader:dateString urlString:URLString];
    
     NSDictionary *dic = @{@"request":@{@"headBean":reqHelp.operationManager.requestSerializer.HTTPRequestHeaders ,@"body":parameters}};
    
     MKLog(@"上行参数：-----\n%@\n",[dic yy_modelToJSONString]);
    [reqHelp.operationManager POST:SERVER_URL parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        MKLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         MKLog(@"下行参数：------\n%@\n", [responseObject yy_modelToJSONString]);
        //存储cookie
        NSDictionary *fields = ((NSHTTPURLResponse*)task.response).allHeaderFields;
        
        NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:fields forURL:[NSURL URLWithString:SERVER_URL]];
        
        
        for (NSHTTPCookie *cookie in cookies) {
            
            [[NSUserDefaults standardUserDefaults] setObject:cookie.value forKey:mUserDefaultsCookie];
        }
        
        if (![NSThread isMainThread]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSMutableDictionary *dic = [responseObject mutableCopy];
                if ([dic[kRESPONSE][kHEAD][kCODE] integerValue] == 1) {
                    success(dic[kRESPONSE][kBODY]);//成功主线程回掉代码快
                } else {
                    success(dic[kRESPONSE][kBODY]);
                    ShowErrorStatus(dic[kRESPONSE][kHEAD][kMSG]);
                    failure(nil);//成功主线程回掉代码快
                }
            });
        }else{
            NSMutableDictionary *dic = [responseObject mutableCopy];
            if ([dic[kRESPONSE][kHEAD][kCODE] integerValue] == 1) {
                success(dic[kRESPONSE][kBODY]);//成功主线程回掉代码快
            } else {
                success(dic[kRESPONSE][kBODY]);
                ShowErrorStatus(dic[kRESPONSE][kHEAD][kMSG]);
                failure(nil);//成功主线程回掉代码快
            }
        }
   
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (![NSThread isMainThread]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);//成功主线程回掉代码快
                ShowErrorStatus(error.localizedDescription);
            });
        }else{
            failure(error);//成功主线程回掉代码快
            ShowErrorStatus(error.localizedDescription);
        }
    }];
}


/**
 上传图片信息
 
 @param photoData 图片data

 */
+ (void)uploadPhotoData:(NSData *)photoData
                success:(SuccessBlock)success
                failure:(FailBlock)failure{
    if(![self isHasNetWork])
    {
        ShowErrorStatus(@"网络连接错误请检查您的网络！");
        return;
    }
    
    //分界线的标识符
    NSString *TWITTERFON_FORM_BOUNDARY = @"fileImg";
    //根据url初始化request
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:IMAGE_URL]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:10];
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];

    //得到图片的data
    NSData* data = photoData; //UIImagePNGRepresentation(image);
//    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
//
    ////添加分界线，换行
    [body appendFormat:@"%@\r\n",MPboundary];
    //声明pic字段，文件名为boris.png
    [body appendFormat:@"Content-Disposition: form-data; name=\"fileImg\"; filename=\"boris.png\"\r\n"];
    //声明上传文件的格式
    [body appendFormat:@"Content-Type: image/png\r\n\r\n"];
//
//    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    //将image的data加入
    [myRequestData appendData:data];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *sessionTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            ShowErrorStatus(@"图片上传失败！");
            failure(error);
            
        } else {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if (error) {
                
                ShowErrorStatus(@"图片上传失败！");
                failure(error);
            } else {
                if (![NSThread isMainThread]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                       
                        if ([dic[kCODE] integerValue] == 100) {
                            success(dic[kBODY]);//成功主线程回掉代码快
                        } else {
                            ShowErrorStatus(dic[kMSG]);
                            failure(error);
                        }
                    });
                }else{
                   
                    if ([dic[kCODE] integerValue] == 100) {
                        success(dic[kBODY]);//成功主线程回掉代码快
                    } else {
                        ShowErrorStatus(dic[kMSG]);
                        failure(error);
                    }
                }

            }
        }
    }];
    [sessionTask resume];
}
+(void)POSTUpdate:(NSString *)URLString parameters:(NSDictionary *)parameters success:(SuccessBlock)success failure:(FailBlock)failure
{
    if(![self isHasNetWork])
    {
        ShowErrorStatus(@"网络连接错误请检查您的网络！");
        return;
    }
    reqHelp =[RequestHelp instanceRequestHelp];
    
    [reqHelp configHTTPHeader:nil urlString:@""];
    
    NSString * url =[NSString stringWithFormat:@"%@%@",SERVER_URL,URLString];
    if (!parameters) {
        parameters = @{};
    }
    
    NSDictionary *dic = @{@"request":@{@"head":reqHelp.operationManager.requestSerializer.HTTPRequestHeaders ,@"body":parameters}};
    MKLog(@"上行参数：-----\n%@\n",[dic yy_modelToJSONString]);
    
    [reqHelp.operationManager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        MKLog(@"下行参数：------\n%@\n", [responseObject yy_modelToJSONString]);
        //存储cookie
        NSDictionary *fields = ((NSHTTPURLResponse*)task.response).allHeaderFields;
        
        NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:fields forURL:[NSURL URLWithString:SERVER_URL]];
        
        
        for (NSHTTPCookie *cookie in cookies) {
            
            [[NSUserDefaults standardUserDefaults] setObject:cookie.value forKey:mUserDefaultsCookie];
        }
        
        if (![NSThread isMainThread]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSMutableDictionary *dic = [responseObject mutableCopy];
                if ([dic[kCODE] integerValue] == 100) {
                    success(dic[kBODY]);//成功主线程回掉代码快
                    return ;
                }
                
                if ([dic[kCODE] integerValue] == 1899) {
                    
                    failure(nil);
                    [[UserManager shareInstance] saveToken:nil];
                    [[UserManager shareInstance] saveUser:nil];
                    [[UserManager shareInstance]removeUserId];
                    [ViewControllerManager showLoginViewController];
                    
                    return ;
                }
                
                //ShowErrorStatus(dic[kMSG]);
                
                failure(nil);
            });
        }else{
            
            NSMutableDictionary *dic = [responseObject mutableCopy];
            if ([dic[kCODE] integerValue] == 100) {
                success(dic[kBODY]);//成功主线程回掉代码快
                return ;
            }
            //  ShowErrorStatus(dic[kMSG]);
            if ([dic[kCODE] integerValue] == 1899) {
                [[UserManager shareInstance] saveToken:nil];
                [[UserManager shareInstance] saveUser:nil];
                [[UserManager shareInstance]removeUserId];
                failure(nil);
                [ViewControllerManager showLoginViewController];
                
                return ;
            }
            // ShowErrorStatus(dic[kMSG]);
            failure(nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DismissHud();
        if (![NSThread isMainThread]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);//成功主线程回掉代码快
                ShowMessage(@"网络异常，请稍后重试");
            });
        }else{
            failure(error);//成功主线程回掉代码快
            ShowMessage(@"网络异常，请稍后重试");
        }
    }];
}


+ (void)GETWeChatWithURL:(NSString *)url
                 success:(SuccessBlock)success
                 failure:(FailBlock)failure{
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                success(dic);
                
            } else {
                failure(nil);
            }
        });
    });
}

+ (void)downViImageCodeWithUrl:(NSString *)url
                        params:(id)param
                       success:(SuccessBlock)success
                       failure:(FailBlock)failure{
    
    reqHelp =[RequestHelp instanceRequestHelp];
    
    [reqHelp configHTTPHeader:nil urlString:url];

    NSMutableURLRequest *mReq = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:SERVER_URL]];
    
    
     NSDictionary *dic = @{@"REQUEST":@{@"HEAD":reqHelp.operationManager.requestSerializer.HTTPRequestHeaders ,@"BODY":param}};
    
    [mReq setHTTPMethod:@"POST"];
    
    NSString *jsonStr = [self convertToJsonData:dic];
    
    [mReq setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    NSData *data= [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    [mReq setHTTPBody:data];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *sessionTask = [session dataTaskWithRequest:mReq completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //存储cookie
        NSDictionary *fields = ((NSHTTPURLResponse*)response).allHeaderFields;
        
        NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:fields forURL:[NSURL URLWithString:SERVER_URL]];
        
        
        for (NSHTTPCookie *cookie in cookies) {
            
            [[NSUserDefaults standardUserDefaults] setObject:cookie.value forKey:mUserDefaultsCookie];
        }

        
        if (![NSThread isMainThread]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error) {
                    ShowErrorStatus(error.localizedDescription);
                    failure(error);
                    return ;
                } else{
                    success(data);
                }

            });
        }else{
            if (error) {
                ShowErrorStatus(error.localizedDescription);
                failure(error);
                return ;
            } else{
                success(data);
            }

        }

        
        
    }];
    [sessionTask resume];

}

+(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

/**
 取消所有队列的请求
 */
- (void)cancelAllOperations{
    [self.operationQueue cancelAllOperations];
}

/**
 网络状态判断
 */
+ (void)addReachabilityNetworkBackHandle:(void (^)())handler{
    //1.创建网络状态监测管理者
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    
    //2.监听改变
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /*
         AFNetworkReachabilityStatusUnknown          = -1,
         AFNetworkReachabilityStatusNotReachable     = 0,
         AFNetworkReachabilityStatusReachableViaWWAN = 1,
         AFNetworkReachabilityStatusReachableViaWiFi = 2,
         */
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        
        AFNetworkReachabilityStatus lastStatus = [def integerForKey:NetworkStatusKey];
        
        [def setInteger:status forKey:NetworkStatusKey];
        [def synchronize];
        
        if ((lastStatus == AFNetworkReachabilityStatusUnknown ||
             lastStatus == AFNetworkReachabilityStatusNotReachable) &&
            (status == AFNetworkReachabilityStatusReachableViaWWAN ||
             status == AFNetworkReachabilityStatusReachableViaWiFi)) {
                
                handler();//回调重新加载
            }
    }];
    // 开始监控
    [manger startMonitoring];
}

+ (BOOL)isHasNetWork{

    AFNetworkReachabilityStatus status = [GetUserDefaults(NetworkStatusKey) integerValue];
    BOOL rst;
    switch (status) {
        case AFNetworkReachabilityStatusUnknown:
           
            rst = NO;
            break;
        case AFNetworkReachabilityStatusNotReachable:
           
            rst = NO;
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
            
            rst = YES;
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi:
 
            rst = YES;
            break;
        default:
            break;
    }
    if (!rst) {
//        [SVProgressHUD showErrorWithStatus:@"当前没有网络，请检查网络连接！"];
//        [SVProgressHUD setMinimumDismissTimeInterval:3];
    }
    return rst;
}


@end
