//
//  SingletonClass.m
//  JXHDemo
//
//  Created by Xinhou Jiang on 16/7/31.
//  Copyright © 2016年 Jiangxh. All rights reserved.
//

#import "SingletonClass.h"

@implementation SingletonClass

/**
 * class单例
 */
+ (SingletonClass *)Ins {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        // 只实例化一次
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)test {
    // 可在整个工程中调用如下代码：
    [SingletonClass Ins].name = @"sharedInstnce";
    //NSString *name = [SingletonClass Ins].name;
}

@end
