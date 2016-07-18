//
//  NewFeatureViewController.m
//  JXHDemo
//
//  Created by Xinhou Jiang on 6/7/16.
//  Copyright © 2016 Jiangxh. All rights reserved.
//  SCROLLVIEW展示新版本特性

#import "NewFeatureViewController.h"
#import "ESTabBarController.h"

// 滚动视图个数
#define ImageNum 3

@interface NewFeatureViewController ()<UIScrollViewDelegate>

@end

@implementation NewFeatureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 添加UIScrollView滚动视图
    [self setupScrollView];
}

/**
 *  添加UIScrollView滚动视图
 */
- (void)setupScrollView
{
    // 创建UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    
    // 设置属性
    scrollView.delegate = self;
    scrollView.frame = self.view.bounds;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    CGSize size = scrollView.frame.size;
    scrollView.contentSize = CGSizeMake(ImageNum * size.width, size.height);
    
    // 添加UIImageView
    for (NSInteger i = 0; i < ImageNum; i++)
    {
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld",i + 1];
        UIImage *image = [UIImage fullscreenImageWithName:imageName];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = image;
        imageView.frame = CGRectMake(i * size.width, 0, size.width, size.height);
        [scrollView addSubview:imageView];
        
        // 最后一张图片添加启动按钮
        if (i == (ImageNum - 1))
        {
            // 开启交互
            imageView.userInteractionEnabled = YES;
            [self setupStartButton:imageView];
        }
    }
}

/**
 *  添加按钮
 */
- (void)setupStartButton:(UIImageView*)inView
{
    // 创建按钮
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    startButton.bounds = CGRectMake(0, 0, 150, 30);
    [startButton setBackgroundColor:[UIColor yellowColor]];
    [startButton setTitle:@"启动" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    startButton.center = CGPointMake(self.view.center.x, self.view.frame.size.height * 0.9);
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    startButton.adjustsImageWhenHighlighted = NO;
    startButton.selected = YES;
    
    // 添加到最后一张图片上
    [inView addSubview:startButton];
}

/**
 *  启动
 */
- (void)start
{
    // 进入主界面
    self.view.window.rootViewController = [[ESTabBarController alloc] init];
}

@end