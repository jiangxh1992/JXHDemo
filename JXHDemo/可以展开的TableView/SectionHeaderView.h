//
//  SectionHeaderView.h
//  JXHDemo
//
//  Created by 919575700@qq.com on 10/23/15.
//  Copyright (c) 2015 Jiangxh. All rights reserved.
//  section头部视图，是一个buntton

#import <UIKit/UIKit.h>
/**
 *  自定义协议
 */
@protocol SectionHeaderDelegate <NSObject>

//点击了section header
- (void)sectionDidClicked:(UIButton *)sender;

@end
@interface SectionHeaderView : UIButton

/**
 *  左边指示图标
 */
@property (nonatomic, strong)UIImageView *icon;

/**
 *  按钮标题
 */
@property (nonatomic, strong)UILabel *title;
/**
 *  记录是否已经展开
 */
@property (nonatomic)BOOL isOpen;

/**
 *  协议
 */
@property (nonatomic, weak) id<SectionHeaderDelegate>delegate;

/**
 *  创建一个按钮
 *
 *  @param icon  icon
 *  @param title title
 *
 *  @return 返回一个SectionHeaderView
 */
- (SectionHeaderView *)initWithIcon:(NSString *)icon andTitle:(NSString *)title;
//+ (SectionHeaderView *)headerView;

@end