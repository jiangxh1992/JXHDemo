//
//  UIBarButtonItem+Extension.h
//  JXHDemo
//
//  Created by 919575700@qq.com on 11/5/15.
//  Copyright © 2015 Jiangxh. All rights reserved.
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