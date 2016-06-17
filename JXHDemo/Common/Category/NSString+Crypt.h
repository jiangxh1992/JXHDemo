//
//  NSString+Crypt.h
//  JXHDemo
//
//  Created by 919575700@qq.com on 11/5/15.
//  Copyright © 2015 Jiangxh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Crypt)

/**
 *  加密
 */
- (NSString *)encrypt;

/**
 *  解密
 */
- (NSString *)decrypt;

@end