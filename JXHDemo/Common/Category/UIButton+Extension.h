//
//  UIButton+Extension.h
//  JXHDemo
//
//  Created by 919575700@qq.com on 11/5/15.
//  Copyright © 2015 Jiangxh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
typedef void (^ActionBlock)();

@interface UIButton (Extension)

@property (readonly) NSMutableDictionary *event;
/**
 *  使用代码块响应按钮事件
 */
- (void) handleControlEvent:(UIControlEvents)controlEvent withBlock:(ActionBlock)action;

/**
 *  快速创建一个button：按钮文字／按钮target事件
 */
+ (instancetype)buttonWithTitle:(NSString *)title target:(id)target action:(SEL)action;

/**
 *  快速创建一个button：按钮名称／常态和高亮图片／按钮target事件
 */
+ (instancetype)buttonWithTitle:(NSString *)title bg:(NSString *)bg target:(id)target action:(SEL)action;

/**
 *  快速创建一个button：按钮名称／常态图片／高亮图片／按钮target事件
 */
+ (instancetype)buttonWithTitle:(NSString *)title normalBg:(NSString *)normalBg highlightedBg:(NSString *)highlightedBg target:(id)target action:(SEL)action;

@end