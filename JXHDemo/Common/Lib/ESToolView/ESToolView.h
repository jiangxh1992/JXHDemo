//
//  ESToolView.h
//  sdfyy
//
//  Created by yh on 15/1/26.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//  可以切换按钮的工具条

#import <UIKit/UIKit.h>
@class ESToolView;

@protocol ESToolViewDelegate <NSObject>

/**
 *  按钮选择切换协议
 */
@optional

/**
 *  选中ESToolView中的第几个按钮
 */
- (void)toolView:(ESToolView *)toolView didSelectedButtonAtIndex:(NSUInteger)index;

@end

@interface ESToolView : UIView

/**
 *  工具条中按钮文字数组
 */
@property (nonatomic, strong) NSArray *buttonNames;

/**
 *  ESToolView代理
 */
@property (nonatomic, assign) id<ESToolViewDelegate> delegate;

/**
 *  当前选择的索引
 */
@property (nonatomic, assign) NSInteger selectedIndex;

/**
 *  创建ESToolView
 */
+ (instancetype)toolView;

@end