//
//  RequestSingleton.h
//  JXHDemo
//
//  Created by Xinhou Jiang on 6/12/16.
//  Copyright © 2016 Jiangxh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestSingleton : NSObject

/**
 *  通用manager
 */
@property (nonatomic, strong) AFHTTPRequestOperationManager *commonManager;

/**
 *  获取QueuesSingleton单例对象
 */
+ (RequestSingleton *)Ins;

/**
 * 原生POST请求(最基础的请求参数是字符串，这里原生的请求参数是一个json字符串)
 */
- (void) POST: (NSString *)url form: (NSString *)param success:(void(^)(id json))success failure: (void(^)(NSError *error))flaiure;

@end
