//
//  AFRequestSingleton.m
//  JXHDemo
//
//  Created by Xinhou Jiang on 16/7/15.
//  Copyright © 2016年 Jiangxh. All rights reserved.
//

#import "AFRequestSingleton.h"
#import "AFHTTPRequestOperationManager+Extension.h"

@implementation AFRequestSingleton

- (id)init {
    if (self = [super init]) {
        // 通用manager
        self.commonManager = [AFHTTPRequestOperationManager compoundMagager];
    }
    return self;
}

+ (AFRequestSingleton *)Ins {
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AFRequestSingleton alloc]init];
    });
    return sharedInstance;
}


@end
