//
//  ImageTool.h
//  smh
//
//  Created by yh on 15/3/19.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//  图片工具类

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface ESImageTool : NSObject

/**
 *  清除SDWebImage缓存的图片
 */
+ (void)clearMemory;

#pragma mark - 加载网络图片
/**
 *   异步加载网络图片
 */
+ (void)downloadImage:(NSString *)url place:(NSString *)place imageView:(UIImageView *)imageView;

/**
 *  (异步加载网络图片)使用默认占位图片
 */
+ (void)downloadImage:(NSString *)url imageView:(UIImageView *)imageView;

@end