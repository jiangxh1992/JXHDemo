//
//  TimerButton.h
//  demo
//
//  Created by jiangxh on 15/9/27.
//  Copyright © 2015年 txbydev3. All rights reserved.
//
/***************************************************
 *重定义一个时间轴节点的button，在button里面嵌套两个button
 ***************************************************/
#import <UIKit/UIKit.h>

@class NodeRecord;

@interface TimerButton : UIButton

/**
 * 子按钮：用来显示节点日期
 */
@property (nonatomic, strong) UIButton *btnDate;

/**
 * 子按钮：用来显示节点就诊内容
 */
@property (nonatomic, strong) UIButton *btnContent;

/**
 * 子视图：用来显示按钮的三角箭头
 */
@property (nonatomic, strong) UIImageView *imgArrow;

/**
 * 最外层按钮的尺寸
 */
@property (nonatomic) CGSize btnSize;

/**
 * 结点数据模型
 */
@property (nonatomic, strong)NodeRecord *nodeRecord;

/**
 * 用frame结构和所在cell行数来初始化按钮组件
 */
- (id)initWithFrame:(CGRect)frame nodeRecord:(NodeRecord *)nodeRecord;

@end