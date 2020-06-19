//
//  TPShareInstance.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2019/7/2.
//  Copyright © 2019年 梦境网络. All rights reserved.
//

#ifndef TPShareInstance_h
#define TPShareInstance_h

// .h文件
#define XHBorrowShareSingleton_H(name) + (instancetype)shared##name;

// .m文件
#define XHBorrowShareSingleton_M(name) \
static id _instace = nil; \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [super allocWithZone:zone]; \
}); \
return _instace; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [[self alloc] init]; \
}); \
return _instace; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instace; \
}


#endif /* TPShareInstance_h */
