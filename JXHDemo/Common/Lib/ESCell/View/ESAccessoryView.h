//
//  ESAccessoryView.h
//  sdfyy
//
//  Created by yh on 15/3/7.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//  键盘辅助视图

#import <UIKit/UIKit.h>

@interface ESAccessoryView : UIView

/**
 *  创建辅助视图
 */
+ (instancetype)accessoryViewWithTarget:(id)target action:(SEL)action;

/**
 *  设置标题文字
 */
- (void)setTitle:(NSString *)title;

@end