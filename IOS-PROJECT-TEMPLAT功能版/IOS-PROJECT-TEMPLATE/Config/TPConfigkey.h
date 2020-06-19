//
//  TPConfigkey.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2019/7/2.
//  Copyright © 2019年 梦境网络. All rights reserved.
//

#ifndef TPConfigkey_h
#define TPConfigkey_h

#ifdef DEBUG
// DEBUG Module Bugly
#define kXHBorrowBuglyAPPID @""
#define kXHBorrowBugConfigChannel @"Development"
#else
// RELEASE Module Bugly
#define kXHBorrowBuglyAPPID @""
#define kXHBorrowBugConfigChannel @"APP Store"
#endif

/*
 本文件存储所有第三方所需的key或密钥,及其app所需链接的url如：客服电话，客服url，各种协议规定url等。
 */

#endif /* TPConfigkey_h */
