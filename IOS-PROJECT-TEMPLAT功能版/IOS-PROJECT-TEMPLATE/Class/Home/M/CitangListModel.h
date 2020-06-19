//
//  CitangListModel.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/18.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CitangListModel : NSObject
//list =     (
//            {
//                ancestralHome = "<null>";
//                createTime = "2020-05-09 09:32:04";
//                ctJs = "";
//                ctJs2 = "\U5f20\U4e09\U5bb6\U65cf\U5386\U53f2\U7b80\U4ecb";
//                deleteStatus = 1;
//                id = 1;
//                img = "";
//                img2 = "http://123.56.153.251:81/dist/jzimg/20200514141250.png";
//                jzId = 1;
//                name = "";
//                name2 = "\U5f20\U6c0f\U5bb6\U65cf";
//                theme = "<null>";
//                type = 0;
//                updateTime = "2020-05-09 09:32:04";
//                userName = "<null>";
//                userUserId = "";
//            }
//            );
@property(nonatomic,strong)NSString * ancestralHome;
@property(nonatomic,strong)NSString * createTime;
@property(nonatomic,strong)NSString * ctJs;
@property(nonatomic,strong)NSString * ctJs2;
@property(nonatomic,strong)NSString * deleteStatus;
@property(nonatomic,strong)NSString * id;
@property(nonatomic,strong)NSString * img;
@property(nonatomic,strong)NSString * img2;
@property(nonatomic,strong)NSString * jzId;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * name2;
@property(nonatomic,strong)NSString * theme;
@property(nonatomic,strong)NSString * type;
@property(nonatomic,strong)NSString * updateTime;
@property(nonatomic,strong)NSString * userName;
@property(nonatomic,strong)NSString * userUserId;
@end

NS_ASSUME_NONNULL_END
