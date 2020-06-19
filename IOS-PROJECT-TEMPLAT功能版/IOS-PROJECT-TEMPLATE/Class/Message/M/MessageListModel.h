//
//  MessageListModel.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/21.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageListModel : NSObject
@property(nonatomic,strong)NSString *update_time;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *delete_status;
@property(nonatomic,strong)NSString *create_time;
@property(nonatomic,strong)NSString *pub_message_id;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSString *isOpen;


@end

NS_ASSUME_NONNULL_END
