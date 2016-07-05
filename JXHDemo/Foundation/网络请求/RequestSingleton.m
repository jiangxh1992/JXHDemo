//
//  RequestSingleton.m
//  JXHDemo
//
//  Created by Xinhou Jiang on 6/12/16.
//  Copyright © 2016 Jiangxh. All rights reserved.
//

#import "RequestSingleton.h"
#import "AFHTTPRequestOperationManager+Extension.h"

@interface RequestSingleton()

/**
 * session,创建一个共用的即可
 */
@property(nonatomic, strong)NSURLSession *session;

@end

@implementation RequestSingleton

/**
 *  获取单例对象
 */
+ (RequestSingleton *)Ins
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

/**
 *  init
 */
- (id)init
{
    if (self = [super init])
    {
        // 通用manager
        self.commonManager = [AFHTTPRequestOperationManager compoundMagager];
        // 通用session
        _session = [NSURLSession sharedSession];
    }
    return self;
}

/**
 * 原生POST请求, 客可对此进一步封装，进行参数的拼接，加密等等
 */
- (void)POST:(NSString *)url form:(NSString *)param success:(void (^)(id json))success failure:(void (^)(NSError *))flaiure {
    NSURL *URL = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"POST";
    // 参数
    request.HTTPBody = [param dataUsingEncoding:NSUTF8StringEncoding];
    // 请求超时
    request.timeoutInterval = 30;
    //根据会话对象创建一个发送请求Task
    NSURLSessionDataTask *dataTask = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 解析数据, 将NSData转成json对象
        id json = [self decrypeJsonWithData:data];
        // 如果error为nil说明没有网络错误，请求成功
        if (!error) {
            // 将数据上抛传出去
            success(json);
            NSLog(@"返回数据：%@",json);
        }else {
            // 网络错误，请求失败，包括请求超时等等
            flaiure(error);
        }
    }];
    //执行任务
    [dataTask resume];
}

/**
 *  NSData转JSON对象
 */
- (id)decrypeJsonWithData:(NSData *)data
{
    // 1. 转成字符串
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    // 2. 解密
    // 如果是加密传输在这里进行解密
    
    // 3. 转成json对象
    return [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
}

@end