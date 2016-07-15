//
//  AFRequestSingleton.h
//  JXHDemo
//
//  Created by Xinhou Jiang on 16/7/15.
//  Copyright © 2016年 Jiangxh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFRequestSingleton : NSObject

/**
 *  通用manager
 */
@property (nonatomic, strong) AFHTTPRequestOperationManager *commonManager;

+ (AFRequestSingleton *)Ins;

@end
