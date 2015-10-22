//
//  CustomCalendarViewController.m
//  demo
//
//  Created by txbydev3 on 15/9/17.
//  Copyright (c) 2015年 txbydev3. All rights reserved.
//

#import "CustomCalendarViewController.h"
@interface CustomCalendarViewController ()
//私有属性
@property (nonatomic, strong) MyCalenderView * customCalendarView;//日历组件
@property (nonatomic, strong) NSCalendar * gregorian;//
@property (nonatomic, assign) NSInteger currentYear;//当前年份
@end

@implementation CustomCalendarViewController

/**
 *1.带参初始化
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
/**
 *2.日历视图加载
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    //日历背景色
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //日历标题
    self.navigationItem.title = @"我的日程";
    //格式化为格利高里日历
    _gregorian       = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //日历的尺寸
    _customCalendarView                             = [[MyCalenderView alloc]initWithFrame:CGRectMake(0, 40, 320, 360)];
    //代理和数据源协议设为self
    _customCalendarView.delegate                    = self;
    _customCalendarView.datasource                  = self;
    //
    _customCalendarView.calendarDate                = [NSDate date];
    //月份 星期以及月份切换按钮的颜色
    _customCalendarView.monthAndDayTextColor        = [UIColor purpleColor];
    //有数据源的日期数字背景色
    _customCalendarView.dayBgColorWithData          = [UIColor clearColor];
    //无数据源的日期数字背景色
    _customCalendarView.dayBgColorWithoutData       = [UIColor clearColor];
    //选中的日期数字背景色
    _customCalendarView.dayBgColorSelected          = [UIColor clearColor];
    //无数据源的日期数字颜色
    _customCalendarView.dayTxtColorWithoutData      = [UIColor blueColor];
    //有数据源的日期数字颜色
    _customCalendarView.dayTxtColorWithData         = [UIColor blueColor];
    //选中的日期数字颜色
    _customCalendarView.dayTxtColorSelected         = [UIColor redColor];
    //边框颜色
    _customCalendarView.borderColor                 = [UIColor redColor];
    //边框宽度
    _customCalendarView.borderWidth                 = 0;
    //设置是否允许点击日期切换月份
    _customCalendarView.allowsChangeMonthByDayTap   = YES;
    //设置是否允许点击按钮切换月份
    _customCalendarView.allowsChangeMonthByButtons  = YES;
    //设置
    _customCalendarView.keepSelDayWhenMonthChange   = YES;
    //日历月份切换动画重置
    _customCalendarView.nextMonthAnimation          = UIViewAnimationOptionTransitionCrossDissolve;
    _customCalendarView.prevMonthAnimation          = UIViewAnimationOptionTransitionCrossDissolve;
    
    dispatch_async(dispatch_get_main_queue(), ^{        
        [self.view addSubview:_customCalendarView];
        _customCalendarView.center = CGPointMake(self.view.center.x, _customCalendarView.center.y);
    });
    
    NSDateComponents * yearComponent = [_gregorian components:NSCalendarUnitYear fromDate:[NSDate date]];
    _currentYear = yearComponent.year;
}

#pragma mark - Gesture recognizer
/**
 *3.
 */
-(void)swipeleft:(id)sender
{
    [_customCalendarView showNextMonth];
}
/**
 *4.
 */
-(void)swiperight:(id)sender
{
    [_customCalendarView showPreviousMonth];
}

#pragma mark - CalendarDelegate protocol conformance
/**
 *5.显示选择的格利高里日期
 */
-(void)dayChangedToDate:(NSDate *)selectedDate
{
    NSLog(@"dayChangedToDate %@(GMT)",selectedDate);
}

#pragma mark - CalendarDataSource protocol conformance
/**
 *6.
 */
-(BOOL)isDataForDate:(NSDate *)date
{
    if ([date compare:[NSDate date]] == NSOrderedAscending)
        return YES;
    return NO;
}
/**
 *7.这里设置日历的年份显示范围
 */
-(BOOL)canSwipeToDate:(NSDate *)date
{
    //定义时间点
    //NSDateComponents * yearComponent = [_gregorian components:NSCalendarUnitYear fromDate:date];
    //return (yearComponent.year == _currentYear || yearComponent.year == _currentYear+1);
    return 1;//返回1表示显示所有年份，没有界限
}

#pragma mark - Action methods

/**
 *8.
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end