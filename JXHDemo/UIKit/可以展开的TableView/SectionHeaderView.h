//
//  SectionHeaderView.h
//  JXHDemo
//
//  Created by 919575700@qq.com on 10/23/15.
//  Copyright (c) 2015 Jiangxh. All rights reserved.
//  section头部视图，是一个buntton

#import <UIKit/UIKit.h>
@class SectionHeaderView;
/**
 *  自定义协议
 */
@protocol SectionHeaderDelegate <NSObject>

//点击了section header
- (void)sectionDidClicked:(SectionHeaderView *)sender;

@end
@interface SectionHeaderView : UIButton

/**
 *  记录是否已经展开
 */
@property (nonatomic)BOOL isOpen;

/**
 *  协议
 */
@property (nonatomic, weak) id<SectionHeaderDelegate>delegate;

@end