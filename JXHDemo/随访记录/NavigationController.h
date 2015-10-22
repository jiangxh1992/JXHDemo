//
//  NavigationController.h
//  demo
//
//  Created by txbydev3 on 15/9/10.
//  Copyright (c) 2015年 txbydev3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationController : UINavigationController

/**
 *初始化导航条基本属性
 */
- (void)initNav;
/**
 *设置当前画面导航条的组件信息
 */
- (void)setNav;
/*
 *点击返回触发的事件
 */
- (void)back;
@end
