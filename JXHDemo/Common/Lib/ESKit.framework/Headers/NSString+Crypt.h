//
//  NSString+Crypt.h
//  ESKit
//
//  Created by yh on 15/4/2.
//  Copyright (c) 2015年 eeesys. All rights reserved.
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