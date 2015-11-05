//
//  QueuesSingleton.h
//  smh
//
//  Created by yh on 15/3/18.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//  AFHTTPRequestOperationManager队列

#import <Foundation/Foundation.h>
@class AFHTTPRequestOperationManager;

@interface QueuesSingleton : NSObject

/**
 *  通用manager
 */
@property (nonatomic, strong) AFHTTPRequestOperationManager *commonManager;

/**
 *  问答manager
 */
@property (nonatomic, strong) AFHTTPRequestOperationManager *questManager;

/**
 *  账号manager（登录注册修改信息）
 */
@property (nonatomic, strong) AFHTTPRequestOperationManager *accountManager;

/**
 *  后台manager（获取未读信息等）
 */
@property (nonatomic, strong) AFHTTPRequestOperationManager *backgroundManager;

/**
 *  药价公示服务价格等其他服务器（明文）
 */
@property (nonatomic, strong) AFHTTPRequestOperationManager *otherManager;

/**
 *  获取QueuesSingleton单例对象
 */
+ (QueuesSingleton *)sharedInstance;

@end