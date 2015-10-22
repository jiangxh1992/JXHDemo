//
//  NavigationController.m
//  demo
//
//  Created by txbydev3 on 15/9/10.
//  Copyright (c) 2015年 txbydev3. All rights reserved.
//

#import "NavigationController.h"
#import "VisitTableTableViewController.h"

@interface NavigationController ()

@end

@implementation NavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化导航条基本属性
    [self initNav];
    //设置当前画面导航条的组件信息
    [self setNav];
    //显示导航栏中的导航条
    [self.view addSubview:self.navigationBar];
    //添加表格视图
    //[self addTableView];
    }
/**
 *重写pushViewController
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 如果不是nav的根控制器
    if (self.viewControllers.count > 0)
    {
        // 添加自定义返回按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    }
    [super pushViewController:viewController animated:animated];
}
/**
 *初始化导航条基本属性
 */
- (void)initNav {
    // 导航栏颜色
    self.navigationBar.barTintColor = RGBColor(18, 96, 150);
    //导航条控件颜色
    self.navigationBar.tintColor = [UIColor blueColor];
    // 导航栏标题颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [self.navigationBar setTitleTextAttributes:textAttrs];
    //定义导航视图背景
    self.view.backgroundColor = RGBColor(240, 240, 240);
}
/**
 *设置当前画面导航条的组件信息
 */
- (void)setNav {
    //设置右侧系统按钮
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
                                                                              target:nil
                                                                              action:nil];
    self.navigationItem.rightBarButtonItem = rightBtn;
    //设置左侧返回按钮
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply
                                                                              target:nil
                                                                              action:nil];
    self.navigationItem.leftBarButtonItem = backBtn;
    //把导航栏集合添加到导航栏中，设置动画关闭
    //[self.navigationBar pushNavigationItem:self.navigationItem animated:NO];
}
/*
 *点击返回触发的事件
 */
- (void)back {
    NSLog(@"点击了返回按钮！");
    [self popViewControllerAnimated:YES];
}
/**
 *添加表格视图
 */
- (void)addTableView {
    //自定义的走访纪录表格视图
    VisitTableTableViewController *tableViewController = [[VisitTableTableViewController alloc] init];
    [self addChildViewController:tableViewController];
}
@end
