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
    // 创建图像视图
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"new_feature_background"];
    // 开启交互
    imageView.userInteractionEnabled = YES;
    // 设置frame
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
    scrollView.delegate = self;
    scrollView.frame = self.view.bounds;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    CGSize size = scrollView.frame.size;
    scrollView.contentSize = CGSizeMake(ESImageCount * size.width, size.height);
    
    // 3 添加UIImageView
    for (NSInteger i = 0; i < ESImageCount; i++)
    {
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld",i + 1];
        UIImage *image = [UIImage fullscreenImageWithName:imageName];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = image;
        imageView.frame = CGRectMake(i * size.width, 0, size.width, size.height);
        [scrollView addSubview:imageView];
        
        // 4 最后一张图片添加分享和立即体验按钮
        if (i == (ESImageCount - 1))
        {
            imageView.userInteractionEnabled = YES;
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
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    startButton.bounds = CGRectMake(0, 0, 180, 50);
    startButton.center = CGPointMake(self.view.center.x, self.view.frame.size.height * 0.9);
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    startButton.adjustsImageWhenHighlighted = NO;
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