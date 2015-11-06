//
//  ImageTool.m
//  smh
//
//  Created by yh on 15/3/19.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import "ESImageTool.h"
#import "UIImageView+WebCache.h"

@implementation ESImageTool

#pragma mark - 清除缓存图片
/**
 *  清除SDWebImage缓存的图片
 */
+ (void)clearMemory
{
    [[SDWebImageManager sharedManager] cancelAll];
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

#pragma mark - 加载网络图片
/**
 *   异步加载网络图片
 */
+ (void)downloadImage:(NSString *)url place:(NSString *)place imageView:(UIImageView *)imageView
{
    [imageView setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:place] options:SDWebImageLowPriority | SDWebImageRetryFailed];
}

/**
 *  (异步加载网络图片)使用默认占位图片
 */
+ (void)downloadImage:(NSString *)url imageView:(UIImageView *)imageView
{
    [self downloadImage:url place:@"loading" imageView:imageView];
}

@end