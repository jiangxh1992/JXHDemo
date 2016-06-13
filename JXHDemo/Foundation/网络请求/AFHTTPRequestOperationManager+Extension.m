//
//  AFHTTPRequestOperationManager+Extension.m
//  JXHDemo
//
//  Created by Xinhou Jiang on 6/8/16.
//  Copyright © 2016 Jiangxh. All rights reserved.
//

#import "AFHTTPRequestOperationManager+Extension.h"

@implementation AFHTTPRequestOperationManager (Extension)

#pragma mark - init
/**
 *  根据responseSerializer和请求参数创建AFHTTPRequestOperationManager
 */
+ (AFHTTPRequestOperationManager *)managerWithResponseSerializer:(AFHTTPResponseSerializer *)serializer
{
    // 创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 返回类型
    manager.responseSerializer = serializer;
    // 请求设置
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    // 不使用默认的cookie处理
    [requestSerializer setHTTPShouldHandleCookies:NO];
    manager.requestSerializer = requestSerializer;
    return manager;
}

/**
 *  创建访问json的manager
 */
+ (instancetype)defaultManager
{
    return [self managerWithResponseSerializer:[AFJSONResponseSerializer serializer]];
}

/**
 *  创建访问加密文本的manager
 */
+ (instancetype)compoundMagager
{
    return [self managerWithResponseSerializer:[AFCompoundResponseSerializer serializer]];
}

#pragma mark - JSON
/**
 *  发送一个GET请求(返回标准JSON)
 */
- (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    // 发送请求
    [self GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (operation.isCancelled) return;
        // 传递block
        if (success)
        {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (operation.isCancelled) return;
        // 传递block
        if (failure)
        {
            failure(error);
        }
    }];
}

/**
 *  发送一个POST请求(返回标准JSON)
 */
- (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    // 发送请求
    [self POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (operation.isCancelled) return;
        // 传递block
        if (success)
        {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (operation.isCancelled) return;
        // 传递block
        if (failure)
        {
            failure(error);
        }
    }];
}

@end