//
//  PickerViewController.m
//  JXHDemo
//
//  Created by 919575700@qq.com on 10/27/15.
//  Copyright (c) 2015 Jiangxh. All rights reserved.
//

#import "PickerViewController.h"

@interface PickerViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
/**
 *  UIPickerView项目选择框
 */
@property (nonatomic, strong)UIPickerView *pickerView;
/**
 *  UIDatePicker时间选择框
 */
@property (nonatomic, strong)UIDatePicker *datePicker;
/**
 *  时间选择框的事件格式
 */
@property (nonatomic, strong)NSDateFormatter *dateFormatter;

@end

@implementation PickerViewController
/**
 *  0.视图加载
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(230, 230, 230);
    // 1.项目选择框UIPickerView
    //[self openPickerView];
    // 2.日期选择框UIDatePicker
    [self openDatePicker];
}
/**
 *  1.UIPickerView
 */
- (void)openPickerView {
    //初始化坐标，尺寸会使用默认的，自己设置无效随便设置
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, ApplicationH/3, 0, 0)];
    //背景色
    _pickerView.backgroundColor = [UIColor whiteColor];
    //显示指示器
    _pickerView.showsSelectionIndicator = YES;
    //设置代理
    _pickerView.delegate = self;
    //数据协议
    _pickerView.dataSource =self;
    //取得列数
    NSLog(@"列数：%li",(long)[_pickerView numberOfComponents]);
    //取得某一列的行数
    NSLog(@"第一列的行数：%li",(long)[_pickerView numberOfRowsInComponent:0]);
    //某一列的尺寸
    //CGSize size = [_pickerView rowSizeForComponent:0];
    //重新加载所有列
    //[_pickerView reloadAllComponents];
    //重新加载某一列
    //[_pickerView reloadComponent:0];
    //使某一列的某一行滚动到视图中心
    [_pickerView selectRow:3 inComponent:0 animated:YES];
    //取得选择了的某一列的某一行
    NSInteger row = [_pickerView selectedRowInComponent:0];
    NSLog(@"第一列选择的行数下标为：%li",(long)row);
    //显示选择框
    [self.view addSubview:_pickerView];
}
#pragma mark - UIPickerView的协议
/**
 *  实现数据协议
 */
//设置选择框的列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}
//设置每一列的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 5;
}
/**
 *  实现事件代理协议
 */
//设置每一列的行高
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 20;
}
//设置每一列的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 100;
}
//设置某行某列的显示标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[NSString alloc] initWithFormat:@"列%li行%li",(long)component,(long)row];
}
//设置某行某列的属性标题
//- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    return [[NSAttributedString alloc] initWithString:@"个性化文字"];
//}
//设置某行某列的显示图标
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
//    return [[UIView alloc] init];
//}
//选择了某行某列,每次滚动改变数据都会触发
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"选择了第%li列第%li行",(long)component,(long)row);
}

/**
 *  2.UIDatePicker
 */
- (void)openDatePicker {
    //初始化坐标，尺寸会使用默认的，自己设置无效随便设置
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, ApplicationH/3, 0, 0)];
    //背景色
    _datePicker.backgroundColor = [UIColor whiteColor];
    //添加到视图显示
    [self.view addSubview:_datePicker];
    //设置时间选择器的时间为当前时间，其实不设置默认也是当前时间
    [_datePicker setDate:[NSDate date]];
    //设置选择框的类型:只显示年月日
    [_datePicker setDatePickerMode:UIDatePickerModeCountDownTimer];
    //设置中文时间选择器
    [_datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"]];
    //定义时间显示格式
    [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //获取时间选择器的时间字符串
    NSString *dateString = [_dateFormatter stringFromDate:_datePicker.date];
    NSLog(@"时间选择器初试时间为：%@",dateString);
}
/**
 时间选择器的几种显示模式：
 UIDatePickerModeTime,           // 显示小时和分钟，以及根据本地系统的设置显示上午和下午
 UIDatePickerModeDate,           // 显示年月日
 UIDatePickerModeDateAndTime,    // 根据本地系统时间格式显示年月日星期小时和分钟，以及根据本地系统的设置显示上午和下午
 UIDatePickerModeCountDownTimer, // 显示用于计时器的小时和分钟
 
 NSDateFormatter的时间显示格式：
 纪元的显示：
 G：显示AD，也就是公元
 年的显示：
 yy：年的后面2位数字
 yyyy：显示完整的年
 月的显示：
 M：显示成1~12，1位数或2位数
 MM：显示成01~12，不足2位数会补0
 MMM：英文月份的缩写，例如：Jan
 MMMM：英文月份完整显示，例如：January
 日的显示：
 d：显示成1~31，1位数或2位数
 dd：显示成01~31，不足2位数会补0
 星期的显示：
 EEE：星期的英文缩写，如Sun
 EEEE：星期的英文完整显示，如，Sunday
 上/下午的显示：
 aa：显示AM或PM
 小时的显示：
 H：显示成0~23，1位数或2位数(24小时制
 HH：显示成00~23，不足2位数会补0(24小时制)
 K：显示成0~12，1位数或2位数(12小時制)
 KK：显示成0~12，不足2位数会补0(12小时制)
 分的显示：
 m：显示0~59，1位数或2位数
 mm：显示00~59，不足2位数会补0
 秒的显示：
 s：显示0~59，1位数或2位数
 ss：显示00~59，不足2位数会补0
 S： 毫秒的显示
 时区的显示：
 z / zz /zzz ：PDT
 zzzz：Pacific Daylight Time
 Z / ZZ / ZZZ ：-0800
 ZZZZ：GMT -08:00
 v：PT
 vvvv：Pacific Time
 */
@end