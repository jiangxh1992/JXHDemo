//
//  NSObject+Extention.m
//  JXHDemo
//
//  Created by 919575700@qq.com on 11/5/15.
//  Copyright © 2015 Jiangxh. All rights reserved.
//

#import "NSObject+Extention.h"

@implementation NSObject (Extention)

-(id)initWithDictionary:(NSDictionary *)dic {
    if (self = [self init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+(id)initWithDictionary:(NSDictionary *)dic {
    return [[self alloc] initWithDictionary:dic];
}

@end