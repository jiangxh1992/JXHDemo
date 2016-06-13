//
//  AFNetworkTest.m
//  JXHDemo
//
//  Created by Xinhou Jiang on 6/8/16.
//  Copyright © 2016 Jiangxh. All rights reserved.
//

#import "AFNetworkTest.h"
#import "RequestSingleton.h"

@implementation AFNetworkTest

- (void)viewDidLoad {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[[NSURL alloc] initWithString:@"hostname"]];
    
    [[RequestSingleton Ins].commonManager POST:testURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"result: %@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"result: %@",error);
    }];
}

@end