//
//  UIView+Extension.h
//  JXHDemo
//
//  Created by 919575700@qq.com on 11/5/15.
//  Copyright © 2015 Jiangxh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

/**
 *  视图的x坐标
 */
@property (nonatomic, assign) CGFloat x;

/**
 *  视图的y坐标
 */
@property (nonatomic, assign) CGFloat y;

/**
 *  视图的中点x
 */
@property (nonatomic, assign) CGFloat centerX;

/**
 *  视图的中点y
 */
@property (nonatomic, assign) CGFloat centerY;

/**
 *  视图的宽度
 */
@property (nonatomic, assign) CGFloat width;

/**
 *  视图的高度
 */
@property (nonatomic, assign) CGFloat height;

/**
 *  视图的宽高
 */
@property (nonatomic, assign) CGSize size;

@end