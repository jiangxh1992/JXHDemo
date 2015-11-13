//
//  NewFeatureViewController.m
//  smh
//
//  Created by yh on 14-5-30.
//  Copyright (c) 2014年 com.eeesys. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "ESTabBarController.h"

// 滚动视图个数
#define ESImageCount 3

@interface NewFeatureViewController ()<UIScrollViewDelegate>

@end

@implementation NewFeatureViewController

#pragma mark - lifecycle
- (void)loadView
{
    // 1 创建图像视图
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"new_feature_background"];
    // 1.1 开启交互
    imageView.userInteractionEnabled = YES;
    // 1.2 设置frame
    imageView.frame = [UIScreen mainScreen].bounds;
    
    self.view = imageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加UIScrollView
    [self setupScrollView];
}

#pragma mark - private
/**
 *  添加UIScrollView
 */
- (void)setupScrollView
{
    // 1 创建UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    
    // 2 设置属性
    // 2.1 设置代码
    scrollView.delegate = self;
    // 2.2 设置frame
    scrollView.frame = self.view.bounds;
    // 2.3 禁止滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    // 2.4 设置分页
    scrollView.pagingEnabled = YES;
    // 2.5 滚动范围
    CGSize size = scrollView.frame.size;
    scrollView.contentSize = CGSizeMake(ESImageCount * size.width, size.height);
    
    // 3 添加UIImageView
    for (NSInteger i = 0; i < ESImageCount; i++)
    {
        // 3.1 图片名
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        // 3.2 创建图像
        UIImage *image = [UIImage fullscreenImageWithName:imageName];
        // 3.3 创建图像视图
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = image;
        imageView.frame = CGRectMake(i * size.width, 0, size.width, size.height);
        // 3.4 添加到滚动视图
        [scrollView addSubview:imageView];
        
        // 4 最后一张图片添加分享和立即体验按钮
        if (i == (ESImageCount - 1))
        {
            // 4.1 UIImageView交互
            imageView.userInteractionEnabled = YES;
            
            // 4.2 添加立即体验
            [self setupStartButton:imageView];
        }
    }
}

/**
 *  添加立即体验
 */
- (void)setupStartButton:(UIImageView*)inView
{
    // 1 创建按钮
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 2 设置属性
    // 2.1 不同状态下的图片
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    // 2.2 设置位置
    startButton.bounds = CGRectMake(0, 0, 180, 50);
    startButton.center = CGPointMake(self.view.center.x, self.view.frame.size.height * 0.9);
    // 2.3 添加事件
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    // 2.4 高亮时去除灰色
    startButton.adjustsImageWhenHighlighted = NO;
    // 2.5 默认为选中状态
    startButton.selected = YES;
    
    // 3 添加到最后一张图片上
    [inView addSubview:startButton];
}

/**
 *  立即体验点击事件
 */
- (void)start
{
    self.view.window.rootViewController = [[ESTabBarController alloc] init];
}

@end