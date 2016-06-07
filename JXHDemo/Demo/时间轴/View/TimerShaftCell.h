//
//  TimerShaftCell.h
//  demo
//
//  Created by jiangxh on 15/9/26.
//  Copyright © 2015年 txbydev3. All rights reserved.
//  时间轴结点样式
#import <UIKit/UIKit.h>

/**
 * 按钮点击事件协议
 */
@protocol TimerButtonDelegate <NSObject>

// 结点内容按钮点击事件
- (void)btnContentDidClicked:(UIButton *)sender;

// 删除结点按钮点击事件
- (void)btnNodeDidClicked:(UIButton *)sender;

@end

@class TimerButton, NodeRecord;
@interface TimerShaftCell : UITableViewCell

/**
 * 日期按钮
 */
@property (nonatomic,strong)TimerButton *timerBtn;

/**
 * 设置委托协议
 */
@property (nonatomic,weak) id<TimerButtonDelegate>delegate;

/**
 * 结点数据模型
 */
@property (nonatomic, strong)NodeRecord *nodeRecord;

/**
 * 构造方法（初始化对象的时候会调用）
 * 添加所需要的控件
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifer:(NSString *)reuseIdentifer nodeRecord:(NodeRecord *)nodeRecord;

@end