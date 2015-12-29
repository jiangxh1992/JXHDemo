//
//  CustomCalendarViewController.m
//  demo
//
//  Created by jiangxh on 15/9/17.
//  Copyright (c) 2015年 txbydev3. All rights reserved.
//
#define calendarY 74 //日历到顶端的高度
#import "CustomCalendarViewController.h"
#import "AddAgencyViewController.h"
@interface CustomCalendarViewController ()<UIAlertViewDelegate>
/*私有属性*/
@property (nonatomic, strong) MyCalenderView * customCalendarView;//日历组件
@property (nonatomic, strong) NSCalendar * gregorian;//日历
@property (nonatomic, assign) NSInteger currentYear;//当前年份
@end

@implementation CustomCalendarViewController

/**
 * 0.日历视图加载
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 日历基本设置
    [self calendarSetting];
    // 变量初始化
    [self elementInit];
}
/**
 * 1.日历基本设置
 */
- (void)calendarSetting {
    // 日历背景色
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // 日历标题
    self.navigationItem.title = @"我的日程";
    // 删除所有事物按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteAll)];
    // 添加日历背景
    UIImageView *calendarBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ApplicationW, ApplicationH)];
    [calendarBg setImage:[UIImage imageNamed:@"calendar_bg"]];
    [self.view addSubview:calendarBg];
}
/**
 * 2.变量初始化
 */
- (void)elementInit {
    //格式化为格利高里日历
    _gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //定义日历以尺寸初始化
    _customCalendarView = [[MyCalenderView alloc]initWithFrame:CGRectMake(0, calendarY, ApplicationW, ApplicationH/5*4)];
    //代理和数据源协议设为当前viewcontroller
    _customCalendarView.delegate   = self;
    _customCalendarView.datasource = self;
    // 异步任务队列
    dispatch_async(dispatch_get_main_queue(), ^{
        //添加日历子视图
        [self.view addSubview:_customCalendarView];
        //设置日历中心点
        _customCalendarView.center = CGPointMake(self.view.center.x, _customCalendarView.center.y);
    });
    //获取并设置当前年份
    NSDateComponents * yearComponent = [_gregorian components:NSCalendarUnitYear fromDate:[NSDate date]];
    _currentYear = yearComponent.year;
}

#pragma mark - Gesture recognizer
/**
 *  3.扫动到下个月
 */
-(void)swipeleft:(id)sender
{
    [_customCalendarView showNextMonth];
}
/**
 *  4.扫动到上个月
 */
-(void)swiperight:(id)sender
{
    [_customCalendarView showPreviousMonth];
}
/**
 *  5.重置本月
 */
- (void)updateCurrentMonth {
    [_customCalendarView reloadCurrentMonth];
}

#pragma mark - 打开当日事务
/**
 *  实现代理协议
 *  6.当点击了日期按钮时，打开当日事务
 */
- (void)openSchedule:(NSString *)dateStr :(UIButton *)sender {
    // 创建事务列表控制器
    AddAgencyViewController *agency = [[AddAgencyViewController alloc] init];
    // 传入对应日期按钮
    agency.sender = sender;
    // 主键，时间戳
    agency.dateStr = dateStr;
    [self.navigationController pushViewController:agency animated:YES];
}

#pragma mark - CalendarDataSource protocol conformance
/**
 *  7.当前实际时间是否大于date
 */
-(BOOL)isDataForDate:(NSDate *)date
{
    //比较日期大小
    if ([date compare:[NSDate date]] == NSOrderedAscending)
        return YES;//date<[NSDate date]
    return NO;
}

/**
 *  8.删除所有事务
 */
- (void)deleteAll {
    // 跟医生确认是否删除所有
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认删除所有事务？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

#pragma mark -alertview代理监听
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex) {
        // 请求服务器删除所有事务记录
        // ... ...
        
        // 删除本地事务记录
        // 获取应用程序沙盒的Documents目录,完整的文件名
        NSString *filename = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject] stringByAppendingPathComponent:@"/agency.plist"];
        // 删除文件夹
        BOOL deleteResult=[[NSFileManager defaultManager] removeItemAtPath:filename error:nil];
        // 提示
        if (deleteResult) {
            XHAlertWithOnlyMsg(@"已删除所有事务!");
        }
        // 重置本月日历
        [self updateCurrentMonth];
    }
}

@end