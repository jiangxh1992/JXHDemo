//
//  XXRequestIns.m
//  JXHDemo
//
//  Created by Xinhou Jiang on 6/29/16.
//  Copyright © 2016 Jiangxh. All rights reserved.
//

#import "XXRequestIns.h"

#define url @"http://192.168.10.110:81/"

@interface XXRequestIns()

/**
 * session
 */
@property(nonatomic, strong)NSURLSession *session;

@end

@implementation XXRequestIns

/**
 *  获取单例对象
 */
+ (XXRequestIns *)Ins
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
        _session = [NSURLSession sharedSession];
    }
    return self;
}

/**
 *  发送请求
 */
- (void)postAPIWithM:(NSString *)m A:(NSString *)a P:(NSDictionary *)p success:(void (^)(id json))success failure:(void(^)(NSError *))flaiure {
    //  组装参数
    NSMutableDictionary *map = [[NSMutableDictionary alloc] init];
    [map setObject:m forKey:@"m"];
    [map setObject:a forKey:@"a"];
    [map setObject:p forKey:@"p"];
    NSString *json = [map JSONString];
    NSString *aes = json;//  加密
    NSString *pack = [NSString stringWithFormat:@"pack=%@",aes];
    [self POST:url form:pack success:^(NSString *data) {
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)POST:(NSString *)Apiurl form:(NSString *)param success:(void (^)(id json))success failure:(void (^)(NSError *))flaiure {
    //根据会话对象创建task
    NSURL *URL = [NSURL URLWithString:Apiurl];
    //创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    //修改请求方法为POST
    request.HTTPMethod = @"POST";
    request.HTTPBody = [param dataUsingEncoding:NSUTF8StringEncoding];
    
    //根据会话对象创建一个Task(发送请求）
    NSURLSessionDataTask *dataTask = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //8.解析数据
        NSString *s = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        
        
        NSLog(@"返回的字符串：%@ end",s);
        
    }];
    //执行任务
    [dataTask resume];
}

@end