//
//  TimerButton.h
//  demo
//
//  Created by txbydev3 on 15/9/27.
//  Copyright © 2015年 txbydev3. All rights reserved.
//
/***************************************************
 *重定义一个时间轴节点的button，在button里面嵌套两个button
 ***************************************************/
#import <UIKit/UIKit.h>
//按钮点击事件协议
@protocol TimerButtonDelegate <NSObject>

//日期按钮点击事件
- (void) btnDateDidClicked:(UIButton *)sender;

@end

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
 * 颜色库：用数组保存自定义的颜色，备用
 */
@property (nonatomic, strong) NSMutableArray *MyColor;
/**
 * 三角形名称库：用数组保存不同颜色的三角图片名称，备用
 */
@property (nonatomic, strong) NSMutableArray *Arrows;
/**
 * 随机颜色下标
 */
@property (nonatomic) NSInteger random;
/**
 * 设置委托协议
 */
@property (nonatomic,weak) id<TimerButtonDelegate>delegate;

@end