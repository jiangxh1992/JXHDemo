//
//  VisitCellFrame.h
//  demo
//
//  Created by txbydev3 on 15/9/10.
//  Copyright (c) 2015年 txbydev3. All rights reserved.
//
/*************************************************************************
 *这个模型用来保存和设置回访记录tableview中的每一个cell中自定义组件的位置和尺寸信息
 *************************************************************************/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class Visit;
@interface VisitCellFrame : NSObject
/**
 *  图标的frame
 */
@property (nonatomic, assign) CGRect iconF;
/**
 *  title的frame
 */
@property (nonatomic, assign) CGRect titleF;
/**
 *  time的frame
 */
@property (nonatomic, assign) CGRect timeF;
/**
 *  verticalline的frame
 */
@property (nonatomic, assign) CGRect verticalLineF;
/**
 *  confirmLabel的frame
 */
@property (nonatomic, assign) CGRect confirmLabelF;
/**
 *无参构造函数
 */
- (VisitCellFrame *)init;
/**
 *
 */
+ (instancetype)VisitCellFrameInit;
@end
