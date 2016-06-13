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

@end
