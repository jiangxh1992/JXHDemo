//
//  SingletonClass.h
//  JXHDemo
//
//  Created by Xinhou Jiang on 16/7/31.
//  Copyright © 2016年 Jiangxh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingletonClass : NSObject

// 测试变量
@property (nonatomic, copy)NSString *name;
// class单例
+ (SingletonClass *)Ins;

@end
