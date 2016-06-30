//
//  AFNetworkTest.m
//  JXHDemo
//
//  Created by Xinhou Jiang on 6/8/16.
//  Copyright © 2016 Jiangxh. All rights reserved.
//

#import "AFNetworkTest.h"
#import "XXRequestIns.h"

@implementation AFNetworkTest

- (void)viewDidLoad {
    
    // 制作参数列表
    NSMutableDictionary *p = [[NSMutableDictionary alloc]init];
    [p setObject:@"jxh" forKey:@"username"];
    [p setObject:@"123" forKey:@"id"];
    
    // 发送post请求
    [[XXRequestIns Ins] postAPIWithM:@"User" A:@"Register" P:p success:^(id json) {
        
        NSLog(@"%@",json);
    } failure:^(NSError *error) {
        
    }];

}

@end