//
//  Account.h
//  Unity-iPhone
//
//  Created by Xinhou Jiang on 6/24/16.
//
//

#import <Foundation/Foundation.h>

@interface Account : NSObject

/**
 *  用户头像
 */
@property (nonatomic, copy) NSString *avatar;

/**
 *  账号
 */
@property (nonatomic, copy) NSString *account;

/**
 *  密码
 */
@property (nonatomic, copy) NSString *password;

@end
