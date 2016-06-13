//
//  RequestSingleton.m
//  JXHDemo
//
//  Created by Xinhou Jiang on 6/12/16.
//  Copyright © 2016 Jiangxh. All rights reserved.
//

#import "RequestSingleton.h"
#import "AFHTTPRequestOperationManager+Extension.h"

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
        [self setManager];
    }
    return self;
}

/**
 *  设置manager
 */
- (void)setManager
{
    self.commonManager = [AFHTTPRequestOperationManager compoundMagager];
}


@end
