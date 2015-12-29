//
//  ESAccessoryView.m
//  sdfyy
//
//  Created by yh on 15/3/7.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

// 按钮到边框的距离
const CGFloat ESInputAccessoryViewDictance = 8;
// 按钮宽度
const CGFloat ESInputAccessoryViewButtonW = 50;
// 选择框inputAccessoryView高度
const CGFloat ESInputAccessoryViewH = 40;

#import "ESAccessoryView.h"

@interface ESAccessoryView ()

/**
 *  标题标签
 */
@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation ESAccessoryView

#pragma mark - 初始化
/**
 *  根据frame创建
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        // 设置属性
        [self setup];
    }
    return self;
}

#pragma mark - 私有方法
/**
 *  设置属性
 */
- (void)setup
{
    // 1. 设置位置
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, ESInputAccessoryViewH);
    // 2. 设置背景颜色
    self.backgroundColor = RGBColor(247, 247, 247);
}

#pragma mark - 公共方法
/**
 *  创建辅助视图
 */
+ (instancetype)accessoryViewWithTarget:(id)target action:(SEL)action
{
    ESAccessoryView *view = [[self alloc] init];
    
    // 1. 取消按钮
    UIButton *cancleButton = [UIButton buttonWithTitle:@"取消" target:target action:action];
    cancleButton.frame = CGRectMake(ESInputAccessoryViewDictance, 0, ESInputAccessoryViewButtonW, ESInputAccessoryViewH);
    [view addSubview:cancleButton];
    
    // 2. 标题
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(CGRectGetMaxX(cancleButton.frame), 0, view.width - 2 *(CGRectGetMaxX(cancleButton.frame)), ESInputAccessoryViewH);
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor darkGrayColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    view.titleLabel = label;
    
    // 3. 确定按钮
    UIButton *okButton = [UIButton buttonWithTitle:@"确定" target:target action:action];
    okButton.frame = CGRectMake(view.width - ESInputAccessoryViewDictance - ESInputAccessoryViewButtonW, 0, ESInputAccessoryViewButtonW, ESInputAccessoryViewH);
    [view addSubview:okButton];
    
    return view;
}

/**
 *  设置标题文字
 */
- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

@end