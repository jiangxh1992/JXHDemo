//
//  UIView+Extension.h
//  smh
//
//  Created by yh on 15/1/17.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//  UIView扩展

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