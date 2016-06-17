//
//  UIButton+Extension.m
//  JXHDemo
//
//  Created by 919575700@qq.com on 11/5/15.
//  Copyright © 2015 Jiangxh. All rights reserved.
//

#import "UIButton+Extension.h"
#import <objc/runtime.h>

typedef void (^ActionBlock)();

@implementation UIButton (Extension)

/**
 *  使用代码块响应按钮事件
 */
static char overviewKey;
@dynamic event;
- (void)handleControlEvent:(UIControlEvents)event withBlock:(ActionBlock)block {
    objc_setAssociatedObject(self, &overviewKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:event];
}
- (void)callActionBlock:(id)sender {
    ActionBlock block = (ActionBlock)objc_getAssociatedObject(self, &overviewKey);
    if (block) {
        block();
    }
}

/**
 *  快速创建一个button：按钮文字／按钮target事件
 */
+ (instancetype)buttonWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    return [self buttonWithTitle:title normalBg:nil highlightedBg:nil target:target action:action];
}

/**
 *  快速创建一个button：按钮名称／常态和高亮图片／按钮target事件
 */
+ (instancetype)buttonWithTitle:(NSString *)title bg:(NSString *)bg target:(id)target action:(SEL)action
{
    NSString *highlightedBg = [bg stringByAppendingString:@"_highlighted"];
    return [self buttonWithTitle:title normalBg:bg highlightedBg:highlightedBg target:target action:action];
}

/**
 *  快速创建一个button：按钮名称／常态图片／高亮图片／按钮target事件
 */
+ (instancetype)buttonWithTitle:(NSString *)title normalBg:(NSString *)normalBg highlightedBg:(NSString *)highlightedBg target:(id)target action:(SEL)action
{
    // 1. 创建button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    // 2. 设置文字
    [button setTitle:title forState:UIControlStateNormal];
    // 3. 文字颜色
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // 4. 正常状态下的背景图片
    [button setBackgroundImage:[UIImage resizedImageWithName:normalBg] forState:UIControlStateNormal];
    // 5. 高亮状态下的背景图片
    [button setBackgroundImage:[UIImage resizedImageWithName:highlightedBg] forState:UIControlStateHighlighted];
    // 6. 监听方法
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

@end