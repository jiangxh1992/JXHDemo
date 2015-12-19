//
//  MyCalenderView.m
//  demo
//
//  Created by jiangxh on 15/9/17.
//  Copyright (c) 2015年 txbydev3. All rights reserved.
//

#import "MyCalenderView.h"

@interface MyCalenderView()

/**
 *  格里高丽日历
 */
@property (nonatomic, strong) NSCalendar *gregorian;

/**
 *  今天
 */
@property (nonatomic, strong) NSDate * today;

/**
 *  选择的日期
 */
@property (nonatomic, strong) NSDate * selectedDate;

/**
 *  日期按钮的宽度
 */
@property (nonatomic, assign) NSInteger dayWidth;

/**
 *  日 月 年 世纪的NSCalendarUnit
 */
@property (nonatomic, assign) NSCalendarUnit dayInfoUnits;

/**
 *  星期的标签数组
 */
@property (nonatomic, strong) NSArray * weekDayNames;

/**
 *  中文月份数组
 */
@property (nonatomic, strong) NSArray *chineseMonth;

/**
 *  手势识别
 */
@property (nonatomic, strong) UISwipeGestureRecognizer * swipeleft;
@property (nonatomic, strong) UISwipeGestureRecognizer * swipeRight;

@end

@implementation MyCalenderView
#pragma mark - init
/**
 * 1.以frame为参数显性初始化
 */
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 背景透明
        self.backgroundColor = [UIColor clearColor];
        // 日期按钮的宽度
        _dayWidth                   = frame.size.width/7;
        // 日历锚点的横纵坐标
        _originX                    = 0;
        _originY                    = _dayWidth;
        // 格利高里日历
        _gregorian                  = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        // 日期初始化为今天
        _calendarDate               = [NSDate date];
        // 今天
        _today                      = [NSDate date];
        // 日历显示单元：世纪／年／月／日
        _dayInfoUnits               = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
        // 按钮背景颜色
        _monthAndDayTextColor       = [UIColor purpleColor];
        _dayBgColorWithoutData      = [UIColor clearColor];//= SLColor(136,203,212);
        _dayBgColorWithData         = [UIColor clearColor];//= SLColor(136,203,212);
        _dayBgColorToday         = [UIColor clearColor];//= SLColor(126,193,202);
        // 按钮文字颜色
        _dayTxtColorWithoutData     = RGBColor(50,50,255);
        _dayTxtColorWithData        = [UIColor blueColor];
        _dayTxtColorToday        = [UIColor redColor];
        _dayTxtColorNotThisMonth    = [UIColor grayColor];
        _alphaOfNotThisMonth        = 0.3;
        // 边框颜色和宽度
        _borderColor                = [UIColor brownColor];
        _borderWidth                = 0;

        // 跳到上个月和下个月的转场动画
        _prevMonthAnimation         = UIViewAnimationOptionTransitionFlipFromLeft;
        _nextMonthAnimation         = UIViewAnimationOptionTransitionFlipFromRight;
        // 字体
        CGFloat fontSize = 20*(ApplicationW/320);
        _defaultFont                = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
        _titleFont                  = [UIFont fontWithName:@"Helvetica-Bold" size:fontSize];
        // 左右滑动手势事件
        // 左滑
        _swipeleft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(showNextMonth)];
        _swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:_swipeleft];
        // 右滑
        _swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(showPreviousMonth)];
        _swipeRight.direction=UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:_swipeRight];
        // 设置第一天初始时间点0h0m0s
        NSDateComponents *components = [_gregorian components:_dayInfoUnits fromDate:[NSDate date]];
        components.hour   = 0;
        components.minute = 0;
        components.second = 0;
        // 初始选中的时间
        _selectedDate = [_gregorian dateFromComponents:components];
        // 设置星期数组名
        _weekDayNames = @[@"一", @"二", @"三", @"四", @"五", @"六", @"日"];
        // 设置月份中文名
        _chineseMonth = @[@"一月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月", @"九月", @"十月", @"十一月", @"十二月"];
    }
    return self;
}

/**
 * 2.初始化日历视图尺寸，暂时用不到
 */
-(id)init {
    // 日历的尺寸为320px宽，400px高
    self = [self initWithFrame:CGRectMake(0, 0, ApplicationW, 400)];
    return self;
}

#pragma mark - Public methods
/**
 * 3.跳到下一个月
 */
-(void)showNextMonth {
    //根据当前月份计算下个月
    NSDateComponents *components = [_gregorian components:_dayInfoUnits fromDate:_calendarDate];
    components.day = 1;
    components.month ++;
    NSDate * nextMonthDate =[_gregorian dateFromComponents:components];
    // 根据当前月份计算下个月
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _calendarDate = nextMonthDate;
    //播放切换动画
    [self performViewAnimation:_nextMonthAnimation];
}

/**
 * 4.跳到上一个月
 */
-(void)showPreviousMonth {
    // 根据当前月份计算上个月
    NSDateComponents *components = [_gregorian components:_dayInfoUnits fromDate:_calendarDate];
    components.day = 1;
    components.month --;
    // 上个月的第一天
    NSDate * prevMonthDate = [_gregorian dateFromComponents:components];
    // 移除当前月份日历视图
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 更新日历日期
    _calendarDate = prevMonthDate;
    //播放切换动画
    [self performViewAnimation:_prevMonthAnimation];
    }
/**
 *  重置本月
 */
- (void)reloadCurrentMonth {
    // 移除当前月份日历视图
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 重置本月视图
    [self setNeedsDisplay];
}

#pragma mark - Various methods
/**
 * 5.根据日期计算按钮的tag标记
 */
-(NSInteger)buttonTagForDate:(NSDate *)date {
    NSDateComponents * componentsDate       = [_gregorian components:_dayInfoUnits fromDate:date];
    NSDateComponents * componentsDateCal    = [_gregorian components:_dayInfoUnits fromDate:_calendarDate];
    // 同年同月
    if (componentsDate.month == componentsDateCal.month && componentsDate.year == componentsDateCal.year) {
        return componentsDate.day;
    }
    else {// 不同月
        NSInteger offsetMonth =  (componentsDate.year - componentsDateCal.year)*12 + (componentsDate.month - componentsDateCal.month);
        return componentsDate.day + offsetMonth*40;
    }
}

/**
 * 6.展示月份切换动画
 */
-(void)performViewAnimation:(UIViewAnimationOptions)animation {
    [UIView transitionWithView:self
                      duration:0.5f
                       options:animation
                    animations:^ { [self setNeedsDisplay]; }
                    completion:nil];
}

#pragma mark - Button creation and configuration
/**
 * 7.按钮创建和布局
 */
-(UIButton *)dayButtonWithFrame:(CGRect)frame {
    UIButton *button                = [UIButton buttonWithType:UIButtonTypeCustom];
    // 按钮字体
    button.titleLabel.font          = _defaultFont;
    // 按钮尺寸
    button.frame                    = frame;
    // 按钮边框颜色
    button.layer.borderColor        = _borderColor.CGColor;
    // 点击事件
    [button addTarget:self action:@selector(tappedDate:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

/**
 * 8.根据日期重新布局按钮
 */
-(void)configureDayButton:(UIButton *)button withDate:(NSDate*)date {
    // 日期转换成日期单元组件对象
    NSDateComponents *dateComponents = [_gregorian components:_dayInfoUnits fromDate:date];
    // 今天转换成日期单元组件对象
    NSDateComponents *todayComponents = [_gregorian components:_dayInfoUnits fromDate:_today];
    // 设置日期按钮的日期文字
    [button setTitle:[NSString stringWithFormat:@"%ld",(long)dateComponents.day] forState:UIControlStateNormal];
    // 为当前日期按钮打上tag
    button.tag = [self buttonTagForDate:date];
    // 1.今天特殊标记
    if(dateComponents.year == todayComponents.year && dateComponents.month == todayComponents.month && dateComponents.day == todayComponents.day) {
        [button setTitleColor:_dayTxtColorToday forState:UIControlStateNormal];
    }
    else {
        // 2.未选中的将来的日期
        button.layer.borderWidth = _borderWidth/2.f;
        [button setTitleColor:_dayTxtColorWithoutData forState:UIControlStateNormal];
        [button setBackgroundColor:_dayBgColorWithoutData];
        // 3.过去的日期
        if (_datasource != nil && [_datasource isDataForDate:date]) {
            [button setTitleColor:_dayTxtColorWithData forState:UIControlStateNormal];
            [button setBackgroundColor:_dayBgColorWithData];
        }
    }
    // 4.不是本月的日期
    NSDateComponents * componentsDateCal = [_gregorian components:_dayInfoUnits fromDate:_calendarDate];
    if (dateComponents.month != componentsDateCal.month) {
        //设置不是本月的日期的字体颜色
        [button setTitleColor:_dayTxtColorNotThisMonth forState:UIControlStateNormal];
        //设置不是本月的日期的字体透明度
        button.alpha = _alphaOfNotThisMonth;
    }
    // 5.设置事务标记
    // 获取应用程序沙盒的Documents目录,完整的文件名
    NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject] stringByAppendingPathComponent:@"/agency.plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    // 将日期转换成字典key
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    // 如果事务内容存在并且不为空则设置标记
    if (data[dateString] && ![data[dateString] isEqualToString:@""]) {
        [button setBackgroundImage:[UIImage imageNamed:@"agencyMark"] forState:UIControlStateNormal];
    }else {
        [button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
}

#pragma mark - Action methods
/**
 * 9.点击了日期按钮
 */
-(void)tappedDate:(UIButton *)sender {
    // 1.点击的日期不是本月的
    if (sender.tag<0 || sender.tag>40) return;
    // 2.点击的日期在显示的月份之内
    // 当前月份
    NSDateComponents *components = [_gregorian components:_dayInfoUnits fromDate:_calendarDate];
    NSDateComponents * componentsDateSel = [_gregorian components:_dayInfoUnits fromDate:_selectedDate];
    if(componentsDateSel.day != sender.tag || componentsDateSel.month != components.month || componentsDateSel.year != components.year)
    {
        //重新定义已选择的日期
        componentsDateSel.day       = sender.tag;
        componentsDateSel.month     = components.month;
        componentsDateSel.year      = components.year;
        _selectedDate               = [_gregorian dateFromComponents:componentsDateSel];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:_selectedDate];
    // 通知日历控制器打开事务记录
    [_delegate openSchedule:destDateString :sender];
}

#pragma mark - Drawing methods
/**
 * 布局要显示的月份的日历
 */
- (void)drawRect:(CGRect)rect {
    // 当前月的第一天
    NSDateComponents *components = [_gregorian components:_dayInfoUnits fromDate:_calendarDate];
    components.day = 1;
    NSDate *firstDayOfMonth         = [_gregorian dateFromComponents:components];
    NSDateComponents *comps         = [_gregorian components:NSCalendarUnitWeekday fromDate:firstDayOfMonth];
    // 计算第一天是星期几
    NSInteger weekdayBeginning      = [comps weekday];//星期日：1；星期一：2；星期二：3； 。。。。
    // 把周一到周日对应转化成：0、1、2、3、4、5、6（即：星期一：0，星期二：1，星期三：2 ... ... 星期日：6）
    weekdayBeginning -=2;
    if(weekdayBeginning < 0)
        weekdayBeginning += 7;
    // 本月的day数组
    NSRange days = [_gregorian rangeOfUnit:NSCalendarUnitDay
                                    inUnit:NSCalendarUnitMonth
                                   forDate:_calendarDate];
    // 本月的总天数
    NSInteger monthLength = days.length;
    // 本月最后一星期剩余的天数，也就是最后一行的本月天数
    NSInteger remainingDays = (monthLength + weekdayBeginning) % 7;
    // 日历轮廓大小
    NSInteger minY = _originY + _dayWidth;//日历高度，只显示一行日期的时候
    NSInteger maxY = _originY + _dayWidth * (NSInteger)(1+(monthLength+weekdayBeginning)/7) + ((remainingDays !=0)? _dayWidth:0);//日历最大高度（展开格式的时候）
    //自定义日期按钮控件，绘制日期按钮排列
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, _borderColor.CGColor);
    CGContextAddRect(context, CGRectMake(_originX - _borderWidth/2.f, minY - _borderWidth/2.f, 7*_dayWidth + _borderWidth, _borderWidth));
    CGContextAddRect(context, CGRectMake(_originX - _borderWidth/2.f, maxY - _borderWidth/2.f, 7*_dayWidth + _borderWidth, _borderWidth));
    CGContextAddRect(context, CGRectMake(_originX - _borderWidth/2.f, minY - _borderWidth/2.f, _borderWidth, maxY - minY));
    CGContextAddRect(context, CGRectMake(_originX + 7*_dayWidth - _borderWidth/2.f, minY - _borderWidth/2.f, _borderWidth, maxY - minY));
    CGContextFillPath(context);
    CGColorSpaceRelease(baseSpace), baseSpace = NULL;
    // 上个月按钮
    UIButton * buttonPrev = [[UIButton alloc] initWithFrame:CGRectMake(10, _dayWidth/4, _dayWidth/2, _dayWidth/2)];
    [buttonPrev setImage:[UIImage imageNamed:@"calendar_pre"] forState:UIControlStateNormal];
    [buttonPrev addTarget:self action:@selector(showPreviousMonth) forControlEvents:UIControlEventTouchUpInside];
    buttonPrev.titleLabel.font = _defaultFont;
    [self addSubview:buttonPrev];
    // 下个月按钮
    UIButton * buttonNext = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width - _dayWidth/2 - 10, _dayWidth/4, _dayWidth/2, _dayWidth/2)];
    [buttonNext setImage:[UIImage imageNamed:@"calendar_next"] forState:UIControlStateNormal];
    [buttonNext addTarget:self action:@selector(showNextMonth) forControlEvents:UIControlEventTouchUpInside];
    buttonNext.titleLabel.font = _defaultFont;
    [self addSubview:buttonNext];
    // 时间点
    NSDateComponents *componentsTmp = [_gregorian components:_dayInfoUnits fromDate:_calendarDate];
    componentsTmp.day = 1;
    componentsTmp.month--;
    componentsTmp.month +=2;
    //年月标签
    NSDateFormatter *formatY = [[NSDateFormatter alloc] init];//年份的显示格式
    NSDateFormatter *formatM = [[NSDateFormatter alloc] init];//月份的显示格式
    [formatY setDateFormat:@"yyyy"];//完整的年份
    [formatM setDateFormat:@"M"];//将月份显示成1-12的数字
    NSString *Year = [formatY stringFromDate:_calendarDate];//年份字符串
    NSString *Month = [formatM stringFromDate:_calendarDate];//月份字符串
    Month = [self toChineseMoth:Month];//月份转换成中文
    //将月份和年份合并成最终年月标题
    NSString *monthYear = [[NSString alloc] initWithFormat:@"%@   %@",Month,Year];
    //显示年月标题
    if (!_hideMonthLabel) {
        UILabel *titleText              = [[UILabel alloc]initWithFrame:CGRectMake(0,0, self.bounds.size.width, _originY)];
        titleText.textAlignment         = NSTextAlignmentCenter;
        titleText.text                  = monthYear;
        titleText.font                  = _titleFont;
        titleText.textColor             = _monthAndDayTextColor;
        [self addSubview:titleText];
    }
    // 日期标签
    __block CGRect frameWeekLabel = CGRectMake(0, _originY, _dayWidth, _dayWidth);
    [_weekDayNames  enumerateObjectsUsingBlock:^(NSString * dayOfWeekString, NSUInteger idx, BOOL *stop)
     {
         frameWeekLabel.origin.x         = _originX+(_dayWidth*idx);
         UILabel *weekNameLabel          = [[UILabel alloc] initWithFrame:frameWeekLabel];
         weekNameLabel.text              = dayOfWeekString;
         weekNameLabel.textColor         = _monthAndDayTextColor;
         weekNameLabel.font              = _defaultFont;
         weekNameLabel.backgroundColor   = [UIColor clearColor];
         weekNameLabel.textAlignment     = NSTextAlignmentCenter;
         [self addSubview:weekNameLabel];
     }];
    // 当前月份显示的日期
    for (NSInteger i= 0; i<monthLength; i++) {
        components.day      = i + 1;
        NSInteger offsetX   = (_dayWidth*((i+weekdayBeginning)%7));
        NSInteger offsetY   = (_dayWidth *((i+weekdayBeginning)/7));
        UIButton *button    = [self dayButtonWithFrame:CGRectMake(_originX+offsetX, _originY+_dayWidth+offsetY, _dayWidth, _dayWidth)];
        [self configureDayButton:button withDate:[_gregorian dateFromComponents:components]];
        [self addSubview:button];
    }
    // 上个月在本月显示的日期
    NSDateComponents *previousMonthComponents = [_gregorian components:_dayInfoUnits fromDate:_calendarDate];
    previousMonthComponents.month --;
    NSDate *previousMonthDate = [_gregorian dateFromComponents:previousMonthComponents];
    NSRange previousMonthDays = [_gregorian rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:previousMonthDate];
    NSInteger maxDate = previousMonthDays.length - weekdayBeginning;
    for (int i=0; i<weekdayBeginning; i++) {
        previousMonthComponents.day     = maxDate+i+1;
        NSInteger offsetX               = (_dayWidth * (i%7));
        NSInteger offsetY               = (_dayWidth * (i/7));
        UIButton *button                = [self dayButtonWithFrame:CGRectMake(_originX+offsetX, _originY + _dayWidth + offsetY, _dayWidth, _dayWidth)];
        [self configureDayButton:button withDate:[_gregorian dateFromComponents:previousMonthComponents]];
        [self addSubview:button];
    }
    // 下个月在本月显示的日期
    if(remainingDays == 0)
        return ;
    NSDateComponents *nextMonthComponents = [_gregorian components:_dayInfoUnits fromDate:_calendarDate];
    nextMonthComponents.month ++;
    for (NSInteger i=remainingDays; i < 7; i++) {
        nextMonthComponents.day         = (i+1)-remainingDays;
        NSInteger offsetX               = (_dayWidth*((i) % 7));
        NSInteger offsetY               = (_dayWidth *((monthLength+weekdayBeginning) / 7));
        UIButton *button                = [self dayButtonWithFrame:CGRectMake(_originX+offsetX, _originY + _dayWidth + offsetY, _dayWidth, _dayWidth)];
        [self configureDayButton:button withDate:[_gregorian dateFromComponents:nextMonthComponents]];
        [self addSubview:button];
    }
}

/**
 *将数字月份转换成中文
 */
- (NSString*)toChineseMoth:(NSString*) month {
    // 将月份字符串转化成int型
    int m = [month intValue];
    return _chineseMonth[m - 1];
}

@end