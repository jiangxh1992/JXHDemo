//
//  MyCalenderView.h
//  demo
//
//  Created by txbydev3 on 15/9/17.
//  Copyright (c) 2015年 txbydev3. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 * 日历代理协议
 */
@protocol CalendarDelegate <NSObject>

-(void)dayChangedToDate:(NSDate *)selectedDate;
//可选实现的接口协议
@optional
-(void)setHeightNeeded:(NSInteger)heightNeeded;
-(void)setMonthLabel:(NSString *)monthLabel;
-(void)setEnabledForPrevMonthButton:(BOOL)enablePrev nextMonthButton:(BOOL)enableNext;
@end

/**
 * 日历数据源协议
 */
@protocol CalendarDataSource <NSObject>

-(BOOL)isDataForDate:(NSDate *)date;
-(BOOL)canSwipeToDate:(NSDate *)date;
@end

@interface MyCalenderView : UIView
/**
 * 显示下一个月的日历
 */
-(void)showNextMonth;
/**
 * 显示上一个月的日历
 */
-(void)showPreviousMonth;

@property (nonatomic,strong) NSDate *calendarDate;
// 日历协议
@property (nonatomic,weak) id<CalendarDelegate> delegate;
// 日历数据源
@property (nonatomic,weak) id<CalendarDataSource> datasource;
// 字体
@property (nonatomic, strong) UIFont * defaultFont;
@property (nonatomic, strong) UIFont * titleFont;
// 月份和工作日的字体颜色
@property (nonatomic, strong) UIColor * monthAndDayTextColor;
// 边框
@property (nonatomic, strong) UIColor * borderColor;//边框颜色
@property (nonatomic, assign) NSInteger borderWidth;//边框宽度
// 按钮颜色
@property (nonatomic, strong) UIColor * dayBgColorWithoutData;//无数据的按钮的颜色
@property (nonatomic, strong) UIColor * dayBgColorWithData;//有数据的按钮的颜色
@property (nonatomic, strong) UIColor * dayBgColorSelected;//选中的按钮的颜色
@property (nonatomic, strong) UIColor * dayTxtColorWithoutData;//无数据的字体的颜色
@property (nonatomic, strong) UIColor * dayTxtColorWithData;//有数据的字体的颜色
@property (nonatomic, strong) UIColor * dayTxtColorSelected;//选中的字体的颜色
// 是否允许用户通过点击另一个月的日期按钮切换月份
@property (nonatomic, assign) BOOL allowsChangeMonthByDayTap;//日期按钮
@property (nonatomic, assign) BOOL allowsChangeMonthBySwipe;//扫动
@property (nonatomic, assign) BOOL allowsChangeMonthByButtons;//切换按钮
// 日历数组的锚点
@property (nonatomic, assign) NSInteger originX;
@property (nonatomic, assign) NSInteger originY;
// 月份切换动画
@property (nonatomic, assign) UIViewAnimationOptions nextMonthAnimation;
@property (nonatomic, assign) UIViewAnimationOptions prevMonthAnimation;
// 选中的日期保留／月份标签
@property (nonatomic, assign) BOOL keepSelDayWhenMonthChange;
@property (nonatomic, assign) BOOL hideMonthLabel;

@end
