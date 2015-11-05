//
//  UIBarButtonItem+Extension.h
//  smh
//
//  Created by yh on 15/1/5.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)


/**
*  快速创建一个显示图片的UIBarButtonItem
*  @param icon   普通图片名称
*/
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon target:(id)target action:(SEL)action;

/**
 *  快速创建一个显示图片的UIBarButtonItem
 *
 *  @param icon     普通图片名称
 *  @param highIcon 高亮图片名称
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;

@end