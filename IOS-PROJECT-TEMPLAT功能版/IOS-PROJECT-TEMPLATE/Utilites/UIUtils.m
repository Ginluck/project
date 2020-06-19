
//
//  UIUtils.m
//  JiFuYiQianBao
//
//  Created by cocoa on 15/2/11.
//  Copyright (c) 2015年 了凡. All rights reserved.
//
#import "UIUtils.h"
#import <CommonCrypto/CommonDigest.h>
#import <sys/utsname.h>
#import <AddressBookUI/AddressBookUI.h>
static NSString * BNlocationChange = @"BNlocationChange";

@interface UIUtils ()
{
//    BMKLocationService *_locService;
//    BMKGeoCodeSearch * _geocodesearch;
//    CLLocationManager * _locationManager;
}
@end
@implementation UIUtils
single_implementation(UIUtils)


+ (BOOL)chargeSuccessWithURL:(NSURL *)url
{
    BOOL success = NO;
    NSString* str = @"success";
    NSString* urlStr = [NSString stringWithFormat:@"%@",url];
    NSRange range = [urlStr rangeOfString:str];
    if (range.length > 0) {
        success = YES;
    }
    
    
    return success;
}


+ (NSMutableDictionary *)groupByTimeWithData:(NSMutableArray *)data OldDictionary:(NSMutableDictionary *)oldDic
{
    NSMutableDictionary* dic = nil;
    if (oldDic.allKeys.count > 0) {
        dic = [NSMutableDictionary dictionaryWithDictionary:oldDic];
    }
    else
        dic = [NSMutableDictionary dictionary];
    
    if (data.count > 0) {
        // 遍历所有的key
        for (NSDictionary* modelDic in data)
        {
            NSString* nKey = [UIUtils stringFromDateString:modelDic.allKeys.lastObject formate:@"yyyyMMddHHmmssSSS" ToFormate:@"yyyy-MM"];
            id model = modelDic.allValues.lastObject;
//            [data removeObject:mod];
            
            NSMutableArray* datas = [NSMutableArray arrayWithObjects:model, nil];
            // 第一次添加
            if (dic.allKeys.count == 0) {
                [dic setObject:datas forKey:nKey];
            }
            else
            {
                BOOL isExist = NO;
                
                // 遍历判断是否存在同样的key
                for (NSString* dicKey in dic.allKeys)
                {
                    if ([nKey isEqualToString:dicKey]) {
                        isExist = YES;
                        break;
                    }
                }
                // 如果存在
                if (isExist) {
                    NSMutableArray* dicDatas = dic[nKey];
                    [dicDatas addObject:model];
                    [dic setObject:dicDatas forKey:nKey];
                    
                }
                else
                    [dic setObject:datas forKey:nKey];
            }
        }
    }
    
    return dic;
}
+(void)CheckAddressBookAuthorization:(void (^)(bool isAuthorized))block
{
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
    
    if (authStatus != kABAuthorizationStatusAuthorized)
    {
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error)
                                                 {
                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         if (error)
                                                         {
                                                             NSLog(@"Error: %@", (__bridge NSError *)error);
                                                         }
                                                         else if (!granted)
                                                         {
                                                             
                                                             block(NO);
                                                         }
                                                         else
                                                         {
                                                             block(YES);
                                                         }
                                                     });  
                                                 });  
    }
    else
    {
        block(YES);
    }
    
}

+ (NSMutableArray *)groupKeysByTimeWithData:(NSMutableArray *)data OldKeys:(NSMutableArray *)oldKeys
{
    NSMutableArray* allKey = nil;
    if (oldKeys.count > 0) {
        allKey = [NSMutableArray arrayWithArray:oldKeys];
    }
    else
        allKey = [NSMutableArray array];
    
    if (data.count > 0) {
        for (NSDictionary* modelDic in data)
        {
            NSString* nKey = [UIUtils stringFromDateString:modelDic.allKeys.lastObject formate:@"yyyyMMddHHmmssSSS" ToFormate:@"yyyy-MM"];
            if (allKey.count == 0) {
                [allKey addObject:nKey];
            }
            else
            {
                BOOL noEqual = NO;
                // 遍历判断是否存在同样的key
                for (NSString* key in allKey)
                {
                    if ([nKey isEqualToString:key]) {
                        noEqual = YES;
                        break;
                    }
                }
                if (!noEqual) {
                    [allKey addObject:nKey];
                }
            }
        }
    }
    
    return allKey;
}

/**
 *  用户名加密
 *
 *  @param userName 用户名
 *
 *  @return 加密后的用户名
 */
+ (NSString *)securtyUserName:(NSString *)userName
{
    if (userName.length > 2) {
        NSMutableString* name = [NSMutableString stringWithFormat:@"%@",userName];
        NSMutableString* nUserName = [NSMutableString string];
        
        NSString* startName = [name substringToIndex:3];
        NSString* endName = [name substringFromIndex:(name.length - 3)];
        
        [nUserName appendString:startName];
        [nUserName appendString:@"***"];
        [nUserName appendString:endName];
        
        return nUserName;
    }
    else
        return userName;
    
}

/**
 *  银行卡加密
 *
 *  @param bankCode 银行卡号
 *
 *  @return 加密后的卡号
 */
+ (NSString *)securtyBankCode:(NSString *)bankCode
{
    if (bankCode.length > 2) {
        NSMutableString* name = [NSMutableString stringWithFormat:@"%@",bankCode];
        NSMutableString* nUserName = [NSMutableString string];
        
        NSString* startName = [name substringToIndex:4];
        NSString* endName = [name substringFromIndex:(name.length - 4)];
        
        [nUserName appendString:startName];
        [nUserName appendString:@" **** **** "];
        [nUserName appendString:endName];
        
        return nUserName;
    }
    else
        return bankCode;
}

+ (NSString *)generateWithLength:(int)len
{
    NSArray* numbers = @[@0, @1, @2, @3, @4, @5, @6, @7, @8, @9,];
    NSMutableString* buffer = [NSMutableString string];
    for (int i = 0 ; i < len; i++) {
        int j = arc4random()%10;
        NSNumber* number = numbers[j];
        [buffer appendFormat:@"%@",number];
    }
    return buffer;
}

/**
 *  生成随机验证码
 *
 *  @param len    验证码长度
 *  @param buffer 接收的指针
 */
void generate(int len,char* buffer)
{
    /*产生密码用的字符串*/
    // 秘钥字符串 0123456789abcdefghiljklnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
    static const char string[]= "0123456789";
    
    for(int i = 0; i < len; i++)
    {
        buffer[i] = string[rand()%strlen(string)]; /*产生随机数*/
    }
}

+ (NSDate *)dateFromString:(NSString *)datestring formate:(NSString *)formate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formate];
    NSDate *date = [dateFormatter dateFromString:datestring];
    
    return date;
}

+ (NSString *)stringFromDate:(NSDate *)date formate:(NSString *)formate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formate];
    NSString *datestring = [dateFormatter stringFromDate:date];
    
    return datestring;
}

+ (NSString *)stringFromDateString:(NSString *)dateStr formate:(NSString *)formate ToFormate:(NSString *)tFormate
{
    NSDate* date = [UIUtils dateFromString:dateStr formate:formate];
    
    return [UIUtils stringFromDate:date formate:tFormate];
}


//+ (CGSize)getSizeWithLabel:(NSString *)des withFont:(UIFont *)font withSize:(CGSize)aSize
//{
//    if (![des isMemberOfClass:[NSNull class]]) {
//        CGSize size;
//        if (bellowIOS7) {
//            size = [des sizeWithFont:font constrainedToSize:aSize lineBreakMode:NSLineBreakByCharWrapping];//MAXFLOAT
//            
//        }
//        else
//        {
//            NSDictionary *attribute = @{NSFontAttributeName: font};
//            //iOS7中提供的计算文本尺寸的方法
//            size = [des boundingRectWithSize:aSize
//                                                 options:NSStringDrawingUsesLineFragmentOrigin |
//                                NSStringDrawingTruncatesLastVisibleLine
//                                              attributes:attribute
//                                                 context:nil].size;
//        }
//        TESTLog(@"size.height:%f",size.height);
//        return size;
//    }
//    return CGSizeZero;
//}

//------------------------ 参数进行排序 -------------------------
//+ (NSString *)compareParam:(NSDictionary *)dic
//{
//    NSMutableString *string = [NSMutableString string];
//    NSArray *keys = [[dic allKeys] sortedArrayUsingSelector:@selector(compare:)];
//    TESTLog(@"keys = %@",keys);
//    for (NSString *aKey in keys) {
//        NSString *value = [dic objectForKey:aKey];
//        TESTLog(@"value = %@",value);
//        [string appendFormat:@"%@%@",value,tSecretKey];
//    }
//    
//    TESTLog(@"string = %@",string);
//    return [UIUtils md5HexDigest:string];
//}

//---------------------- MD5加密 ------------------------
+ (NSString *) md5HexDigest:(NSString *)string
{
    const char *original_str = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash uppercaseString];
}

#pragma mark - 数据持久化
//数据持久化保存
+ (void)saveArray:(NSArray *)aData LocationFileName:(NSString *)fileName
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    NSString *documentLibraryPath = [documentPath stringByAppendingPathComponent:fileName];
    [aData writeToFile:documentLibraryPath atomically:YES];
//    TESTLog(@"文件写入成功");
}

+ (NSArray *)readFromDocumentPlist:(NSString *)fileName
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    NSString *documentLibraryPath = [documentPath stringByAppendingPathComponent:fileName];
    NSArray* array = [NSArray arrayWithContentsOfFile:documentLibraryPath];
    return array;
}

+ (NSString *)pathFromDocument:(NSString *)fileName
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    NSString *documentLibraryPath = [documentPath stringByAppendingPathComponent:fileName];
    return documentLibraryPath;
}


+ (long long)countDirectorySize:(NSString *)directory {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取到目录下面所有的文件名
    NSArray *fileNames = [fileManager subpathsOfDirectoryAtPath:directory error:nil];
    
    long long sum = 0;
    for (NSString *fileName in fileNames) {
        NSString *filePath = [directory stringByAppendingPathComponent:fileName];
        
        NSDictionary *attribute = [fileManager attributesOfItemAtPath:filePath error:nil];
        
        //        NSNumber *filesize = [attribute objectForKey:NSFileSize];
        long long size = [attribute fileSize];
        
        sum += size;
    }
    
    return sum;
}

/**
 *  正则判断密码
 *
 *  @param password 密码字符串
 *
 *  @return 是否正确
 */
+(BOOL)isValidatePassWord:(NSString *)password
{
    // 密码只能为 6 - 32 位数字，字母及常用符号组成
    NSString *passRegex = @"^[A-Za-z0-9\\^$\\.\\+\\*_@!#%&amp;~=-]{6,32}$";
    NSPredicate *passTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passRegex];
    
    return [passTest evaluateWithObject:password];
}

/**
 *  正则判断用户名
 *
 *  @param userName 用户名字符串
 *
 *  @return 是否正确
 */
+ (BOOL)isValidateUserName:(NSString *)userName
{
    // 请用字母、数字、下划线,至少6个字符
    NSString *nameRegex = @"^([a-zA-Z0-9_]){6,20}$";
    
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    
    return [nameTest evaluateWithObject:userName];
}
+ (BOOL) IsIdentityCard:(NSString *)IDCardNumber
{
    if (IDCardNumber.length <= 0) {
        return NO;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:IDCardNumber];
}
/**
 描述：利用正则判断邮箱格式是否正确
 参数：需要判断的字符串
 **/
+(BOOL)isValidateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}

/*手机号码验证 MODIFIED BY HELENSONG*/
+ (BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

+ (void)getVersionInfoWithAppid:(int)appid infoResult:(CheckVersionInfo)block
{
    NSString *urlstring = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%d",appid];
    urlstring = [urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (block != nil) {
            block(result);
        }
    }];
}

#pragma mark - 数据解析相关方法
+ (NSMutableArray *)getGoodsModelFromArray:(NSArray *)data
{
    NSMutableArray* goodsArray = [NSMutableArray array];
    
    return goodsArray;
     
}


//压缩图片
#pragma mark- 缩放图片
+(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

+(UIImage*)getEllipseImageWithImage:(UIImage*)originImage padding:(CGFloat)padding
{
    UIColor* epsBackColor = [UIColor clearColor];//图像的背景色
    CGSize originsize = originImage.size;
    CGRect originRect = CGRectMake(0, 0, originsize.width, originsize.height);
    
    UIGraphicsBeginImageContext(originsize);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //目标区域。
    CGRect desRect =  CGRectMake(padding, padding,originsize.width-(padding*2), originsize.height-(padding*2));
    
    //设置填充背景色。
    CGContextSetFillColorWithColor(ctx, epsBackColor.CGColor);
    UIRectFill(originRect);//真正的填充
    
    //设置椭圆变形区域。
    CGContextAddEllipseInRect(ctx,desRect);
    CGContextClip(ctx);//截取椭圆区域。
    
    [originImage drawInRect:originRect];//将图像画在目标区域。
    
    UIImage* desImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return desImage;
}

+ (NSString *)creatTimeWith:(NSString *)dateStr{
//    TESTLog(@"time:%@",dateStr);
    dateStr =[dateStr stringByReplacingOccurrencesOfString:@"T" withString:@""];
//    TESTLog(@"dateStr:%@",dateStr);
    NSDateFormatter * fmt =[[NSDateFormatter alloc]init];
    [fmt setDateFormat:@"yyyyMMddHHmmss"];
    NSDate * date =[fmt dateFromString:dateStr];
//    TESTLog(@"date:%@",date);
    
    NSDate * now =[NSDate date];
    NSTimeInterval delta =[now timeIntervalSinceDate:date];
    
    if (delta < 60) {
        return @"刚刚";
    }else if (delta < 60 *60){
        NSInteger minute =roundf(delta/60);
        fmt.dateFormat =@"mm";
        return [NSString stringWithFormat:@"%d分钟前",minute];
    }else if (delta < 60 *60 *24){
        fmt.dateFormat =@"HH:mm";
        return [fmt stringFromDate:date];
    }else if (delta < 60 *60 * 24 *2){
        fmt.dateFormat =@"HH:mm";
        return [NSString stringWithFormat:@"昨天 %@",[fmt stringFromDate:date]];
    }else{
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:date];
    }
}
//@"MM月dd日  HH:mm"
+ (NSString *)creatTimeWithTimeString:(NSString *)time dateFormat:(NSString *)format{
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyyMMdd'T'HHmmss"];
    NSDate *dater =[dateFormatter dateFromString:time];
    NSDateFormatter *dateFor =[[NSDateFormatter alloc]init];
    [dateFor setDateFormat:format];
    NSString *timer =[dateFor stringFromDate:dater];
    return timer;
}
+ (NSString *)creatTimeWithTimeString:(NSString *)time dateFormat:(NSString *)format dateFomat:(NSString*)format2{
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:format];
    NSDate *dater =[dateFormatter dateFromString:time];
    NSDateFormatter *dateFor =[[NSDateFormatter alloc]init];
    [dateFor setDateFormat:format2];
    NSString *timer =[dateFor stringFromDate:dater];
    return timer;
}
+(NSString *)translationArabicNum:(NSInteger)arabicNum
{
    NSString *arabicNumStr = [NSString stringWithFormat:@"%ld",(long)arabicNum];
    NSArray *arabicNumeralsArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chineseNumeralsArray = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"个",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chineseNumeralsArray forKeys:arabicNumeralsArray];
    
    if (arabicNum < 20 && arabicNum > 9) {
        if (arabicNum == 10) {
            return @"十";
        }else{
            NSString *subStr1 = [arabicNumStr substringWithRange:NSMakeRange(1, 1)];
            NSString *a1 = [dictionary objectForKey:subStr1];
            NSString *chinese1 = [NSString stringWithFormat:@"十%@",a1];
            return chinese1;
        }
    }else{
        NSMutableArray *sums = [NSMutableArray array];
        for (int i = 0; i < arabicNumStr.length; i ++)
        {
            NSString *substr = [arabicNumStr substringWithRange:NSMakeRange(i, 1)];
            NSString *a = [dictionary objectForKey:substr];
            NSString *b = digits[arabicNumStr.length -i-1];
            NSString *sum = [a stringByAppendingString:b];
            if ([a isEqualToString:chineseNumeralsArray[9]])
            {
                if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
                {
                    sum = b;
                    if ([[sums lastObject] isEqualToString:chineseNumeralsArray[9]])
                    {
                        [sums removeLastObject];
                    }
                }else
                {
                    sum = chineseNumeralsArray[9];
                }
                
                if ([[sums lastObject] isEqualToString:sum])
                {
                    continue;
                }
            }
            
            [sums addObject:sum];
        }
        NSString *sumStr = [sums  componentsJoinedByString:@""];
        NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
        return chinese;
    }
}
+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *str = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    NSString *cString;
    if (str.length>7)
    {
            cString =[str substringFromIndex:3];
    }
    else
    {
        cString =str;
    }
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}


//UIColor转16进制string
+(NSString *) changeUIColorToRGB:(UIColor *)color{
    
    
    const CGFloat *cs=CGColorGetComponents(color.CGColor);
    
    
    NSString *r = [NSString stringWithFormat:@"%@",[self  ToHex:cs[0]*255]];
    NSString *g = [NSString stringWithFormat:@"%@",[self  ToHex:cs[1]*255]];
    NSString *b = [NSString stringWithFormat:@"%@",[self  ToHex:cs[2]*255]];
    return [NSString stringWithFormat:@"#%@%@%@",r,g,b];
    
    
}


//十进制转十六进制
+(NSString *)ToHex:(int)tmpid
{
    NSString *endtmp=@"";
    NSString *nLetterValue;
    NSString *nStrat;
    int ttmpig=tmpid%16;
    int tmp=tmpid/16;
    switch (ttmpig)
    {
        case 10:
            nLetterValue =@"A";break;
        case 11:
            nLetterValue =@"B";break;
        case 12:
            nLetterValue =@"C";break;
        case 13:
            nLetterValue =@"D";break;
        case 14:
            nLetterValue =@"E";break;
        case 15:
            nLetterValue =@"F";break;
        default:nLetterValue=[[NSString alloc]initWithFormat:@"%i",ttmpig];
            
    }
    switch (tmp)
    {
        case 10:
            nStrat =@"A";break;
        case 11:
            nStrat =@"B";break;
        case 12:
            nStrat =@"C";break;
        case 13:
            nStrat =@"D";break;
        case 14:
            nStrat =@"E";break;
        case 15:
            nStrat =@"F";break;
        default:nStrat=[[NSString alloc]initWithFormat:@"%i",tmp];
            
    }
    endtmp=[[NSString alloc]initWithFormat:@"%@%@",nStrat,nLetterValue];
    return endtmp;
}


#pragma mark - BaiDuMap
//- (void)startBaiduMap{
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8) {
//        // //由于IOS8中定位的授权机制改变 需要进行手动授权
//        if (!_locationManager) {
//            _locationManager = [[CLLocationManager alloc] init];
//            _locationManager.delegate =self;
//        }
//    }
//    _locService =[[BMKLocationService alloc]init];
//    _locService.delegate =self;
//    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyBest];
//    [BMKLocationService setLocationDistanceFilter:100.f];
//    [_locService startUserLocationService];
//}
//- (void)stopBaiduMap{
//    [_locService stopUserLocationService];
//    _locService.delegate =nil;
//    _geocodesearch.delegate =nil;
//}
//
//#pragma mark -BMKLocationServiceDelegate
//- (void)willStartLocatingUser{
//    TESTLog(@"即将开始定位");
//    
//}
//- (void)didStopLocatingUser{
//    TESTLog(@"结束定位");
//}
//
//#pragma mark- CLLocationManagerDelegate
//- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
//{
//    switch (status) {
//        case kCLAuthorizationStatusDenied:
//            [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithBool:NO] forKey:@"GPS"];
//            break;
//        case kCLAuthorizationStatusAuthorizedAlways:
//            [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithBool:YES] forKey:@"GPS"];
//            break;
//            
//        case kCLAuthorizationStatusAuthorizedWhenInUse:
//            [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithBool:YES] forKey:@"GPS"];
//            break;
//        default:
//            break;
//    }
//}
//
//- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
//{
//    TESTLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
//    NSString * latitudeStr =[NSString stringWithFormat:@"%.6f",userLocation.location.coordinate.latitude];
//    NSString *longitudeStr =[NSString stringWithFormat:@"%.6f",userLocation.location.coordinate.longitude];
//    CGFloat latitude =[latitudeStr floatValue];
//    CGFloat longitude =[longitudeStr floatValue];
//    NSUserDefaults *df =[NSUserDefaults standardUserDefaults];
//    [df setObject:latitudeStr forKey:@"latitude"];
//    [df setObject:longitudeStr forKey:@"longitude"];
//    [df synchronize];
//    [[NSNotificationCenter defaultCenter]postNotificationName:BNlocationChange object:nil];
//    TESTLog(@"%@",latitudeStr);
//    TESTLog(@"%@",longitudeStr);
//    TESTLog(@"%@",[df objectForKey:@"latitude"]);
//    [self reverseGeoWithLongitude:longitude latitude:latitude];
//}

//- (void)reverseGeoWithLongitude:(CGFloat)longitude latitude:(CGFloat)latitude{
//
//    //初始化检索对象
//    if (!_geocodesearch) {
//        _geocodesearch =[[BMKGeoCodeSearch alloc]init];
//    }
//    _geocodesearch.delegate =self;
//    BMKReverseGeoCodeOption * reverseGeoSeatdhOption =[[BMKReverseGeoCodeOption alloc]init];
//    CLLocationCoordinate2D pt =(CLLocationCoordinate2D){latitude,longitude};
//    reverseGeoSeatdhOption.reverseGeoPoint =pt;
//    BOOL flag =[_geocodesearch reverseGeoCode:reverseGeoSeatdhOption];
//    if (flag) {
//        TESTLog(@"反geo检索发送成功");
//    }else{
//        TESTLog(@"反geo检索发送失败");
//    }
//}
#pragma mark -BMKGeoCodeSearchDelegate
//接收反向地理编码结果
//- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
//    if (error == BMK_SEARCH_NO_ERROR) {
//        NSString * province =result.addressDetail.province;
//        NSString * city =result.addressDetail.city;
//        NSUserDefaults * df1 =[NSUserDefaults standardUserDefaults];
//        [df1 setObject:province forKey:@"province"];
//        [df1 setObject:city forKey:@"city"];
//        TESTLog(@"反地理编码成功");
//    }else{
//        TESTLog(@"抱歉，未找到结果");
//    }
//}


//+(CGSize)getSizeWithMaxSize:(CGSize)maxSize WithFontSize:(int)fontSize str:(NSString *)str
//
//{
//    CGSize size;
//    if (bellowIOS7){
//        size=[str sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
//    }else{
//        size=[str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]} context:nil].size;
//    }
//    return size;
//
//}
+ (NSString *)iphoneType
{
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    
    return platform;
}
+(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

//+(NSDictionary *)getUrlHeadWithString:(NSString *)urlString;
//{
//    return @{@"SERVICEID":urlString,
//                          @"TOKEN":@"",
//                         @"TYPE":TYPE,
//                          @"USERID":@"",
//                          @"CHANNELID":CHANNELID,
//                          @"UUID":UUID,
//                          @"DEVICETYPE":DEVICETYPE,
//                          @"DEVICEPIXELS ":DEVICEPIXELS,
//                          @"OSVERSION":OSVERSION,
//                          @"APPVERSION":APPVERSION,
//                          @"DATE":DATE
//               };
//}



#pragma mark根据时间戳进行时间判断
+(NSString *)getHXtimeStr:(long long)timestamp
{
    // 创建日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 获取当前时间
    NSDate *currentDate = [NSDate date];
    // 获取当前时间的年、月、日。利用日历
    NSDateComponents *components = [calendar components:NSCalendarUnitYear| NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
    NSInteger currentYear = components.year;
    NSInteger currentMonth = components.month;
    NSInteger currentDay = components.day;
    // 获取消息发送时间的年、月、日
    NSDate *msgDate = [NSDate dateWithTimeIntervalSince1970:timestamp / 1000.0];
    components = [calendar components:NSCalendarUnitYear| NSCalendarUnitMonth|NSCalendarUnitDay fromDate:msgDate];
    CGFloat msgYear = components.year;
    CGFloat msgMonth = components.month;
    CGFloat msgDay = components.day;
    // 进行判断
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc] init];
    if (currentYear == msgYear && currentMonth == msgMonth && currentDay == msgDay)
    {
        //今天
        dateFmt.dateFormat = @"HH:mm";
    }
    else if (currentYear == msgYear && currentMonth == msgMonth && currentDay-1 == msgDay)
    {
        //昨天
        dateFmt.dateFormat = @"昨天 HH:mm";
    }
    else if(currentYear==msgYear && currentMonth==msgMonth && currentDay-msgDay>1 &&currentDay-msgDay<=7)
    {
        //当前时间的2天之前且一周之内
        NSString *week=[self getHXWeekDayFordate:timestamp];
        dateFmt.dateFormat=[NSString stringWithFormat:@"%@ HH:mm",week];
        
    }
    else if(currentYear-msgYear>=1)
    {
        //今年之前
        dateFmt.dateFormat=@"yyyy-MM-dd HH:mm";
    }
    else
    {
        //前天前
        dateFmt.dateFormat = @"MM-dd HH:mm";
    }
    // 返回处理后的结果
    return [dateFmt stringFromDate:msgDate];
}

//+(NSString *)HXtextFromMessage:(EMMessage *)message
//{
//    EMMessageBody *body = message.body;
//    EMTextMessageBody *textBody = (EMTextMessageBody *)body;
//    NSString *text = textBody.text;
//    return text;
//}
#pragma mark根据时间戳获取周几
+(NSString *)getHXWeekDayFordate:(long long)data
{
    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:data];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components =[calendar components:NSCalendarUnitWeekday fromDate:newDate];
    NSString *weekStr =[weekday objectAtIndex:components.weekday];
    return weekStr;
}
@end
