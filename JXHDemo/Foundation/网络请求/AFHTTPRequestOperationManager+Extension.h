//
//  AFHTTPRequestOperationManager+Extension.h
//  smh
//
//  Created by yh on 15/3/19.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//  网络工具类

#import "AFHTTPRequestOperationManager.h"

@interface AFHTTPRequestOperationManager (Extension)

/**
 *  创建访问json的manager
 */
+ (instancetype)defaultManager;

/**
 *  创建访问加密文本的manager
 */
+ (instancetype)compoundMagager;

#pragma mark - 服务端返回标准JSON用下面两个方法
/**
 *  发送一个GET请求
 */
- (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

/**
 *  发送一个POST请求
 */
- (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

#pragma mark - 服务端返回加密JSON用下面两个方法
/**
 *  发送一个GET请求
 */
- (void)compoundGetWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

/**
 *  发送一个POST请求
 */
- (void)compoundPostWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

@end