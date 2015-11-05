//
//  ESTabBarButton.m
//  smh
//
//  Created by yh on 14/11/17.
//  Copyright (c) 2014年 eeesys. All rights reserved.
//

// 图标的比例
CGFloat const ESTabBarButtonImageRatio = 0.6;
// 按钮的默认文字颜色
#define  ESTabBarButtonTitleColor (iOS7 ?  RGBColor(151, 151, 151): [UIColor whiteColor])
// 按钮的选中文字颜色
#define  ESTabBarButtonTitleSelectedColor (iOS7 ? RGBColor(100, 156, 33) : RGBColor(97, 154, 30))

#import "ESTabBarButton.h"
#import <ESKit/ESBadgeView.h>

@interface ESTabBarButton()

/**
 *  提醒数字
 */
@property (nonatomic, weak) ESBadgeView *badgeButton;

@end

@implementation ESTabBarButton

#pragma mark - getters
- (ESBadgeView *)badgeButton
{
    if (!_badgeButton)
    {
        // 添加提醒数字
        ESBadgeView *badgeButton = [[ESBadgeView alloc] init];
        _badgeButton = badgeButton;
        badgeButton.hidden = YES;
        [self addSubview:badgeButton];
    }
    return _badgeButton;
}

#pragma mark - setters
/**
 *  设置UITabBarItem
 */
- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    // KVO 监听属性改变
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

#pragma mark - init
/**
 *  根据frame初始化
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 1. 设置按钮属性
        [self setup];
    }
    return self;
}

#pragma mark - private
/**
 *  设置按钮的属性
 */
- (void)setup
{
    // 1. 图标居中
    self.imageView.contentMode = UIViewContentModeCenter;
    // 2. 文字居中
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    // 3. 字体大小
    self.titleLabel.font = [UIFont systemFontOfSize:10];
    // 4. 文字颜色
    [self setTitleColor:ESTabBarButtonTitleColor forState:UIControlStateNormal];
    [self setTitleColor:ESTabBarButtonTitleSelectedColor forState:UIControlStateSelected];
    // 5. 非iOS7下,设置按钮选中时的背景
    if (!iOS7)
    {
        [self setBackgroundImage:[UIImage imageWithName:@"tabbar_slider"] forState:UIControlStateSelected];
    }
}

/**
 *  监听到某个对象的属性改变了,就会调用
 *  @param keyPath 属性名
 *  @param object  哪个对象的属性被改变
 *  @param change  属性发生的改变
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 设置文字
    [self setTitle:self.item.title forState:UIControlStateSelected];
    [self setTitle:self.item.title forState:UIControlStateNormal];
    
    // 设置图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
    // 提醒数字
    self.badgeButton.badgeValue = self.item.badgeValue;
}

#pragma mark - super
/**
 *  去掉高亮状态
 */
- (void)setHighlighted:(BOOL)highlighted {}

/**
 *  内部图片的frame
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * ESTabBarButtonImageRatio;
    return CGRectMake(0, 1, imageW, imageH);
}

/**
 *  内部文字的frame
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * ESTabBarButtonImageRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

/**
 *  销毁时
 */
- (void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
}

/**
 *  调整子视图
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置提醒数字的位置和尺寸
    //self.badgeButton.x = self.frame.size.width / 2 + 10;
    //self.badgeButton.y = 0;
}

@end