//
//  APIString.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2019/9/9.
//  Copyright © 2019年 梦境网络. All rights reserved.
//

#ifndef APIString_h
#define APIString_h
//192.168.0.123 121.36.59.7

#define SERVER_URL @"http://192.168.0.104:8085/"
//#define SERVER_URL @"http://192.168.0.2:8085/"
//#define SERVER_URL @"http://121.36.59.7:8085/"

#define IMAGE_URL @"http://192.168.0.104:8085/appUpload/FILE_UPLOAD"
//#define IMAGE_URL @"http://192.168.0.2:8085/appUpload/FILE_UPLOAD"
//#define IMAGE_URL @"http://121.36.59.7:8085/appUpload/FILE_UPLOAD"


/**
 用户及个人中心模块
 */
//用户登陆

#define  login_url  @"userApp/login"
//用户登陆

#define  GETSECURITYCODE_url  @"userApp/GETSECURITYCODE"


#define  GETSECURITY_url  @"userApp/GETSECURITY"

//退出登录

#define  exit_url  @"userApp/exit"
//修改密码

#define  UPDATE_PC_url  @"userApp/UPDATE_PC"
//忘记密码

#define  UPDATE_WJ_url  @"userApp/UPDATE_WJ"
//验证密码

#define  UPDATE_PHONE_url  @"userApp/UPDATE_PHONE"
//修改手机号

#define  registers_url  @"userApp/registers"
//查找个人信息

#define  SELECT_USERINFO_url  @"userApp/SELECT_USERINFO"
//认祖信息

#define  selectByApply_url  @"apply/selectByApply"
//通过和驳回

#define  update_url  @"apply/update"
//修改个人资料

#define  UPDATE_ZJ_url  @"userApp/UPDATE_ZJ"
//供奉记录

#define  selectAppRechargeRecord  @"appRechargeRecord/selectAppRechargeRecord"




//2.4.1 查询省
#define SELECT_PROVINCE_URL  @"userApp/SELECT_PROVINCE"
//2.5.1 查询市
#define SELECT_CITY_URL  @"userApp/SELECT_CITY"
//2.6.1 查询区
#define SELECT_AREA_URL  @"userApp/SELECT_AREA"
//协议
#define selectByAll_URL  @"appAgreement/selectByAll"






//创建家族
#define JS_CREATE_FAMILY_URL @"appJz/addJz"
//族谱列表&寻找家族$家族详情
#define JS_FAMILY_LIST_URL @"appJz/selectByUser"
//寻找家族
#define JS_FAMILY_LIST_URL2 @"appJz/selectByUser2"
//查看族谱列表
#define JS_SELECT_ZPLIST_URL @"appZp/selectByAppZuPu"
//查看祠堂列表
#define JS_SELECT_CTLIST_URL @"appCt/selectByAppCiTang"
//添加上一代or下一代
#define JS_ADD_NEWMEMBER_URL @"appZp/addAppZuPu"
//确认自己
#define JS_insert_URL @"apply/insert"
//系统消息
#define JS_SYSMESSAGE_LILST_URL @"appPushRecord/list"
//申请查看族谱
#define JS_APPLYZP_URL @"apply/insert"
//获取回话列表
#define JS_GETCONVERSATION_URL @"userApp/BASE_PHONE_GAIN_MESSAGE"
//祭品列表
#define JS_JIPIN_LIST_URL @"appSacrifice/list"
//族谱成员详情
#define JS_MEMBER_DETAIL_URL @"appZp/selectByDetailsApp"
//修改族谱成员&删除成员
#define JS_UPDATE_MEMBER_URL @"appZp/updateAppZuPu"
//创建祠堂
#define JS_CREATE_CITANG_URL @"appCt/appAddCiTang"
//祠堂详情
#define JS_CITANG_DETAIL_URL @"appCt/selectByAppCtDetail"
//祠堂修改
#define JS_CITANG_UPDATE_URL @"appCt/updateAppCiTang"
//购买祭品
#define JS_BUY_PRO_URL @"appRechargeRecord/addAppRechargeRecord"
//供奉记录
#define JS_GONFENG_RECORD_LIST @"appRechargeRecord/selectAppRechargeRecord"
//快速寻祖
#define select_LIST_URL @"appJz/select"
//绑定族谱
#define update_appZp_URL @"appZp/update"

//祠堂祭品
#define JS_JIPINPUT_URL @"appRechargeRecord/selectAppJiPin"

//查询用户余额
#define appSelectYuEById_URL @"appRechargeRecord/appSelectYuEById"
//设置为管理员
#define JS_SETADMIN_URL @"appZp/updateAdminByIdAndJzId"
//管理员修改家族简介
#define JS_updateJz_URL @"appJz/updateJz"
//意见反馈
#define JS_FEEDBACK_URL @"userApp/addAppYj"
//签到记录
#define JS_SIGNRECORD_URL @"appQd/appSelectSignIn"
//签到操作
#define JS_SIGNIN_URL @"appQd/appAddSignIn"
//领取额外奖励
#define JS_GETREWARD_URL @"appQd/appAddAdditionalReward"
//查询是否反馈意见
#define JS_ISFEEDBACK_URL @"userApp/selectOpinionIsExist"
//纪念币消费记录
#define JS_SELECTCOINRECORD_URL @"appRechargeRecord/appSelectByCommemorativeCoinRecord"


#endif /* APIString_h */
