//
//  SingletonClass.m
//  JXHDemo
//
//  Created by Xinhou Jiang on 16/7/31.
//  Copyright © 2016年 Jiangxh. All rights reserved.
//

#import "SingletonClass.h"

@implementation SingletonClass

// class单例
+ (SingletonClass *)Ins {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        // 只实例化一次
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

// 截断copyWithZone:
+ (id)copyWithZone:(struct _NSZone *)zone{
    return [SingletonClass Ins];
}
- (id)copyWithZone:(NSZone *)zone{
    return [SingletonClass Ins];
}
+ (id)mutableCopyWithZone:(struct _NSZone *)zone{
    return [SingletonClass Ins];
}
- (id)mutableCopyWithZone:(NSZone *)zone{
    return [SingletonClass Ins];
}

// 测试
- (void)test {
    // 可在整个工程中调用如下代码：
    [SingletonClass Ins].name = @"sharedInstnce";
    NSString *name = [SingletonClass Ins].name;
}

@end
