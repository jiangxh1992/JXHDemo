//
//  UIImage+Extension.h
//  smh
//
//  Created by yh on 15/1/5.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  根据文件名来适配不同屏幕
 */
+ (UIImage *)fullscreenImageWithName:(NSString *)name;

/**
 *  加载图片
 *  @param name 图片名
 */
+ (UIImage *)imageWithName:(NSString *)name;


/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;


/**
 *  指定x y返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name xPos:(CGFloat)xPos yPos:(CGFloat)yPos;

/**
 *  获取指定点的图片颜色
 */
- (UIColor *)colorAtPixel:(CGPoint)point;

@end