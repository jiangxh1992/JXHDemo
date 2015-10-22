//
//  MyCalenderView.m
//  demo
//
//  Created by txbydev3 on 15/9/17.
//  Copyright (c) 2015年 txbydev3. All rights reserved.
//

#import "MyCalenderView.h"

@interface MyCalenderView()

//格里高丽日历
@property (nonatomic, strong) NSCalendar *gregorian;
//选择的日期
@property (nonatomic, strong) NSDate * selectedDate;
//日期按钮的宽度
@property (nonatomic, assign) NSInteger dayWidth;
//日 月 年 世纪的NSCalendarUnit
@property (nonatomic, assign) NSCalendarUnit dayInfoUnits;
//工作日的标签数组
@property (nonatomic, strong) NSArray * weekDayNames;
//视图晃动
@property (nonatomic, assign) NSInteger shakes;
@property (nonatomic, assign) NSInteger shakeDirection;
//手势识别
@property (nonatomic, strong) UISwipeGestureRecognizer * swipeleft;
@property (nonatomic, strong) UISwipeGestureRecognizer * swipeRight;

@end

@implementation MyCalenderView
#pragma mark -
/**
*1.以frame为参数显性初始化
*/
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //背景透明
        self.backgroundColor = [UIColor clearColor];
        //日期按钮的宽度
        _dayWidth                   = frame.size.width/8;
        //日历锚点的横纵坐标
        _originX                    = (frame.size.width - 7*_dayWidth)/2;
        _originY                    = _dayWidth;
        //格利高里日历
        _gregorian                  = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        //边框宽度
        _borderWidth                = 0;
        //
        _calendarDate               = [NSDate date];
        //日历显示单元：世纪／年／月／日
        _dayInfoUnits               = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
        //按钮颜色
        _monthAndDayTextColor       = [UIColor brownColor];
        _dayBgColorWithoutData      = [UIColor whiteColor];
        _dayBgColorWithData         = [UIColor whiteColor];
        _dayBgColorSelected         = [UIColor brownColor];
        //文字颜色
        _dayTxtColorWithoutData     = [UIColor brownColor];
        _dayTxtColorWithData        = [UIColor brownColor];
        _dayTxtColorSelected        = [UIColor whiteColor];
        //边框颜色
        _borderColor                = [UIColor brownColor];
        //月份切换模式允许设置
        _allowsChangeMonthByDayTap  = NO;
        _allowsChangeMonthByButtons = NO;
        _allowsChangeMonthBySwipe   = YES;
        _hideMonthLabel             = NO;
        _keepSelDayWhenMonthChange  = NO;
        //跳到上个月和下个月的转场动画
        _nextMonthAnimation         = UIViewAnimationOptionCurveLinear;
        _prevMonthAnimation         = UIViewAnimationOptionCurveLinear;
        //字体
        _defaultFont                = [UIFont fontWithName:@"HelveticaNeue" size:15.0f];
        _titleFont                  = [UIFont fontWithName:@"Helvetica-Bold" size:15.0f];
        //左右滑动手势事件
        //左滑
        _swipeleft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(showNextMonth)];
        _swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:_swipeleft];
        //右滑
        _swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(showPreviousMonth)];
        _swipeRight.direction=UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:_swipeRight];
        //设置第一天初始时间点0h0m0s
        NSDateComponents *components = [_gregorian components:_dayInfoUnits fromDate:[NSDate date]];
        components.hour         = 0;
        components.minute       = 0;
        components.second       = 0;
        _selectedDate = [_gregorian dateFromComponents:components];
        //显示星期几？
        NSArray * shortWeekdaySymbols = [[[NSDateFormatter alloc] init] shortWeekdaySymbols];
        _weekDayNames  = @[shortWeekdaySymbols[1], shortWeekdaySymbols[2], shortWeekdaySymbols[3], shortWeekdaySymbols[4],
                           shortWeekdaySymbols[5], shortWeekdaySymbols[6], shortWeekdaySymbols[0]];
    }
    return self;
}
/**
 *2.
 */
-(id)init {
    //日历的尺寸为320px宽，400px高
    self = [self initWithFrame:CGRectMake(0, 0, 320, 400)];
    return self;
}

#pragma mark - Custom setters
/**
 *3.允许点击日期按钮切换月份
 */
-(void)setAllowsChangeMonthByButtons:(BOOL)allows {
    _allowsChangeMonthByButtons = allows;
    [self setNeedsDisplay];
}
/**
 *4.设置允许滑动切换月份
 */
-(void)setAllowsChangeMonthBySwipe:(BOOL)allows {
    _allowsChangeMonthBySwipe   = allows;
    _swipeleft.enabled          = allows;
    _swipeRight.enabled         = allows;
}
/**
 *5.
 */
-(void)setHideMonthLabel:(BOOL)hideMonthLabel {
    _hideMonthLabel = hideMonthLabel;
    [self setNeedsDisplay];
}
/**
 *6.
 */
-(void)setSelectedDate:(NSDate *)selectedDate {
    _selectedDate = selectedDate;
    [self setNeedsDisplay];
}
/**
 *7.设置日历日期
 */
-(void)setCalendarDate:(NSDate *)calendarDate {
    _calendarDate = calendarDate;
    [self setNeedsDisplay];
}


#pragma mark - Public methods
/**
 *8.跳到下一个月
 */
-(void)showNextMonth {
    NSDateComponents *components = [_gregorian components:_dayInfoUnits fromDate:_calendarDate];
    components.day = 1;
    components.month ++;
    NSDate * nextMonthDate =[_gregorian dateFromComponents:components];
    
    if ([self canSwipeToDate:nextMonthDate]) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        _calendarDate = nextMonthDate;
        components = [_gregorian components:_dayInfoUnits fromDate:_calendarDate];
        
        if (!_keepSelDayWhenMonthChange) {
            _selectedDate = [_gregorian dateFromComponents:components];
        }
        [self performViewAnimation:_nextMonthAnimation];
    }
    else {
        [self performViewNoSwipeAnimation];
    }
}

/**
 *9.跳到上一个月
 */
-(void)showPreviousMonth {
    NSDateComponents *components = [_gregorian components:_dayInfoUnits fromDate:_calendarDate];
    components.day = 1;
    components.month --;
    NSDate * prevMonthDate = [_gregorian dateFromComponents:components];
    if ([self canSwipeToDate:prevMonthDate])
    {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        _calendarDate = prevMonthDate;
        components = [_gregorian components:_dayInfoUnits fromDate:_calendarDate];
        if (!_keepSelDayWhenMonthChange) {
            _selectedDate = [_gregorian dateFromComponents:components];
        }
        [self performViewAnimation:_prevMonthAnimation];
    }
    else {
        [self performViewNoSwipeAnimation];
    }
}

#pragma mark - Various methods

/**
 *10.
 */
-(NSInteger)buttonTagForDate:(NSDate *)date {
    NSDateComponents * componentsDate       = [_gregorian components:_dayInfoUnits fromDate:date];
    NSDateComponents * componentsDateCal    = [_gregorian components:_dayInfoUnits fromDate:_calendarDate];
    
    if (componentsDate.month == componentsDateCal.month && componentsDate.year == componentsDateCal.year) {
        // Both dates are within the same month : buttonTag = day
        return componentsDate.day;
    }
    else {
        //  buttonTag = deltaMonth * 40 + day
        NSInteger offsetMonth =  (componentsDate.year - componentsDateCal.year)*12 + (componentsDate.month - componentsDateCal.month);
        return componentsDate.day + offsetMonth*40;
    }
}
/**
 *11.
 */
-(BOOL)canSwipeToDate:(NSDate *)date {
    if (_datasource == nil)
        return YES;
    return [_datasource canSwipeToDate:date];
}
/**
 *12.展示月份切换动画
 */
-(void)performViewAnimation:(UIViewAnimationOptions)animation {
    NSDateComponents * components = [_gregorian components:_dayInfoUnits fromDate:_selectedDate];
    
    NSDate *clickedDate = [_gregorian dateFromComponents:components];
    [_delegate dayChangedToDate:clickedDate];
    
    [UIView transitionWithView:self
                      duration:0.5f
                       options:animation
                    animations:^ { [self setNeedsDisplay]; }
                    completion:nil];
}
/**
 *13.在月份边界扫动或点击日期时触发
 */
-(void)performViewNoSwipeAnimation {
    _shakeDirection = 1;
    _shakes = 0;
    [self shakeView:self];
}
/**
 *14.在月份边界扫动或点击日期时播放摇动动画
 */
-(void)shakeView:(UIView *)theOneYouWannaShake {
    [UIView animateWithDuration:0.05 animations:^{theOneYouWannaShake.transform = CGAffineTransformMakeTranslation(5*_shakeDirection, 0);}
                     completion:^(BOOL finished) {
                         if(_shakes >= 4) {
                             theOneYouWannaShake.transform = CGAffineTransformIdentity;
                             return;
                         }
                         _shakes++;
                         _shakeDirection = _shakeDirection * -1;//摇动方向取反
                         [self shakeView:theOneYouWannaShake];
                     }];
}

#pragma mark - Button creation and configuration
/**
 *15.按钮创建和布局
 */
-(UIButton *)dayButtonWithFrame:(CGRect)frame {
    UIButton *button                = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font          = _defaultFont;
    button.frame                    = frame;
    button.layer.borderColor        = _borderColor.CGColor;
    [button addTarget:self action:@selector(tappedDate:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
/**
 *16.布局按钮
 */
-(void)configureDayButton:(UIButton *)button withDate:(NSDate*)date {
    NSDateComponents *components = [_gregorian components:_dayInfoUnits fromDate:date];
    [button setTitle:[NSString stringWithFormat:@"%ld",(long)components.day] forState:UIControlStateNormal];
    button.tag = [self buttonTagForDate:date];
    
    if([_selectedDate compare:date] == NSOrderedSame)
    {
        // Selected button
        button.layer.borderWidth = 0;
        [button setTitleColor:_dayTxtColorSelected forState:UIControlStateNormal];
        [button setBackgroundColor:_dayBgColorSelected];
    }
    else
    {
        // Unselected button
        button.layer.borderWidth = _borderWidth/2.f;
        [button setTitleColor:_dayTxtColorWithoutData forState:UIControlStateNormal];
        [button setBackgroundColor:_dayBgColorWithoutData];
        
        if (_datasource != nil && [_datasource isDataForDate:date])
        {
            [button setTitleColor:_dayTxtColorWithData forState:UIControlStateNormal];
            [button setBackgroundColor:_dayBgColorWithData];
        }
    }
    
    NSDateComponents * componentsDateCal = [_gregorian components:_dayInfoUnits fromDate:_calendarDate];
    if (components.month != componentsDateCal.month)
        button.alpha = 0.6f;
}

#pragma mark - Action methods
/**
 *17.点击了日期按钮
 */
-(void)tappedDate:(UIButton *)sender {
    //时间点
    NSDateComponents *components = [_gregorian components:_dayInfoUnits fromDate:_calendarDate];
    if (sender.tag < 0 || sender.tag >= 40) {
        //点击的日期不是本月的
        if (!_allowsChangeMonthByDayTap)//如果设置了不允许通过点击日期按钮切换则不响应
            return;
        NSInteger offsetMonth   = (sender.tag < 0)?-1:1;//判断是点击到上一个月还是下一个月
        NSInteger offsetTag     = (sender.tag < 0)?40:-40;
        //初始化另一个月
        components.day = 1;
        components.month += offsetMonth;//设置点击到上一个月还是下一个月
        NSDate * otherMonthDate =[_gregorian dateFromComponents:components];
        if ([self canSwipeToDate:otherMonthDate]) {
            [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            _calendarDate = otherMonthDate;
            //如果是点击日期按钮切换的月份，则把另一个月份的当前日期设置为点击的日期
            components.day = sender.tag + offsetTag;
            //
            _selectedDate = [_gregorian dateFromComponents:components];
            //设置切换动画
            UIViewAnimationOptions animation = (offsetMonth >0)?_nextMonthAnimation:_prevMonthAnimation;
            [self performViewAnimation:animation];
        }
        else {
            [self performViewNoSwipeAnimation];
        }
        return;
    }
    //点击的日期在显示的月份之内
    NSDateComponents * componentsDateSel = [_gregorian components:_dayInfoUnits fromDate:_selectedDate];
    if(componentsDateSel.day != sender.tag || componentsDateSel.month != components.month || componentsDateSel.year != components.year)
    {
        //留一个上次选择的日期的备份
        NSDate * oldSelectedDate = [_selectedDate copy];
        //重新定义已选择的日期
        componentsDateSel.day       = sender.tag;
        componentsDateSel.month     = components.month;
        componentsDateSel.year      = components.year;
        _selectedDate               = [_gregorian dateFromComponents:componentsDateSel];
        //布局新的选择的日期按钮
        [self configureDayButton:sender withDate:_selectedDate];
        //布局之前选择的日期按钮，如果可见的话
        UIButton *previousSelected =(UIButton *) [self viewWithTag:[self buttonTagForDate:oldSelectedDate]];
        if (previousSelected)
            [self configureDayButton:previousSelected withDate:oldSelectedDate];
        //通知代理
        [_delegate dayChangedToDate:_selectedDate];
    }
}
#pragma mark - Drawing methods
/**
 *重载函数
 *18.布局日历
 */
- (void)drawRect:(CGRect)rect {
    //日期组件
    NSDateComponents *components = [_gregorian components:_dayInfoUnits fromDate:_calendarDate];
    components.day = 1;
    NSDate *firstDayOfMonth         = [_gregorian dateFromComponents:components];
    NSDateComponents *comps         = [_gregorian components:NSCalendarUnitWeekday fromDate:firstDayOfMonth];
    NSInteger weekdayBeginning      = [comps weekday];
    weekdayBeginning -=2;
    if(weekdayBeginning < 0)
        weekdayBeginning += 7;
    //本月的day数组
    NSRange days = [_gregorian rangeOfUnit:NSCalendarUnitDay
                                    inUnit:NSCalendarUnitMonth
                                   forDate:_calendarDate];
    NSInteger monthLength = days.length;//本月的总天数
    NSInteger remainingDays = (monthLength + weekdayBeginning) % 7;//本月剩余的天数，也就是最后一个星期剩余的天数
    // 日历轮廓大小
    NSInteger minY = _originY + _dayWidth;//日历高度，只显示一行日期的时候
    NSInteger maxY = _originY + _dayWidth * (NSInteger)(1+(monthLength+weekdayBeginning)/7) + ((remainingDays !=0)? _dayWidth:0);//日历最大高度（展开格式的时候）
    if (_delegate != nil && [_delegate respondsToSelector:@selector(setHeightNeeded:)])
        [_delegate setHeightNeeded:maxY];
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, _borderColor.CGColor);
    CGContextAddRect(context, CGRectMake(_originX - _borderWidth/2.f, minY - _borderWidth/2.f, 7*_dayWidth + _borderWidth, _borderWidth));
    CGContextAddRect(context, CGRectMake(_originX - _borderWidth/2.f, maxY - _borderWidth/2.f, 7*_dayWidth + _borderWidth, _borderWidth));
    CGContextAddRect(context, CGRectMake(_originX - _borderWidth/2.f, minY - _borderWidth/2.f, _borderWidth, maxY - minY));
    CGContextAddRect(context, CGRectMake(_originX + 7*_dayWidth - _borderWidth/2.f, minY - _borderWidth/2.f, _borderWidth, maxY - minY));
    CGContextFillPath(context);
    CGColorSpaceRelease(baseSpace), baseSpace = NULL;
    BOOL enableNext = YES;
    BOOL enablePrev = YES;
    // 上下月切换按钮
    //上个月按钮
    UIButton * buttonPrev = [[UIButton alloc] initWithFrame:CGRectMake(_originX, 0, _dayWidth, _dayWidth)];
    [buttonPrev setTitle:@"<" forState:UIControlStateNormal];
    [buttonPrev setTitleColor:_monthAndDayTextColor forState:UIControlStateNormal];
    [buttonPrev addTarget:self action:@selector(showPreviousMonth) forControlEvents:UIControlEventTouchUpInside];
    buttonPrev.titleLabel.font          = _defaultFont;
    [self addSubview:buttonPrev];
    //下个月按钮
    UIButton * buttonNext = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width - _dayWidth - _originX, 0, _dayWidth, _dayWidth)];
    [buttonNext setTitle:@">" forState:UIControlStateNormal];
    [buttonNext setTitleColor:_monthAndDayTextColor forState:UIControlStateNormal];
    [buttonNext addTarget:self action:@selector(showNextMonth) forControlEvents:UIControlEventTouchUpInside];
    buttonNext.titleLabel.font          = _defaultFont;
    [self addSubview:buttonNext];
    //时间点
    NSDateComponents *componentsTmp = [_gregorian components:_dayInfoUnits fromDate:_calendarDate];
    componentsTmp.day = 1;
    componentsTmp.month --;
    NSDate * prevMonthDate =[_gregorian dateFromComponents:componentsTmp];
    if (![self canSwipeToDate:prevMonthDate]) {
        buttonPrev.alpha    = 0.5f;
        buttonPrev.enabled  = NO;
        enablePrev          = NO;
    }
    componentsTmp.month +=2;
    NSDate * nextMonthDate =[_gregorian dateFromComponents:componentsTmp];
    if (![self canSwipeToDate:nextMonthDate]) {
        buttonNext.alpha    = 0.5f;
        buttonNext.enabled  = NO;
        enableNext          = NO;
    }
    if (!_allowsChangeMonthByButtons) {
        buttonNext.hidden = YES;
        buttonPrev.hidden = YES;
    }
    if (_delegate != nil && [_delegate respondsToSelector:@selector(setEnabledForPrevMonthButton:nextMonthButton:)])
        [_delegate setEnabledForPrevMonthButton:enablePrev nextMonthButton:enableNext];
    //年月标签
    NSDateFormatter *format         = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMMM yyyy"];
    NSString *dateString            = [[format stringFromDate:_calendarDate] uppercaseString];
    if (!_hideMonthLabel) {
        UILabel *titleText              = [[UILabel alloc]initWithFrame:CGRectMake(0,0, self.bounds.size.width, _originY)];
        titleText.textAlignment         = NSTextAlignmentCenter;
        titleText.text                  = dateString;
        titleText.font                  = _titleFont;
        titleText.textColor             = _monthAndDayTextColor;
        [self addSubview:titleText];
    }
    if (_delegate != nil && [_delegate respondsToSelector:@selector(setMonthLabel:)])
        [_delegate setMonthLabel:dateString];
    //日期标签
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
    //当前月份
    for (NSInteger i= 0; i<monthLength; i++) {
        components.day      = i+1;
        NSInteger offsetX   = (_dayWidth*((i+weekdayBeginning)%7));
        NSInteger offsetY   = (_dayWidth *((i+weekdayBeginning)/7));
        UIButton *button    = [self dayButtonWithFrame:CGRectMake(_originX+offsetX, _originY+_dayWidth+offsetY, _dayWidth, _dayWidth)];
        [self configureDayButton:button withDate:[_gregorian dateFromComponents:components]];
        [self addSubview:button];
    }
    //上个月
    NSDateComponents *previousMonthComponents = [_gregorian components:_dayInfoUnits fromDate:_calendarDate];
    previousMonthComponents.month --;
    NSDate *previousMonthDate = [_gregorian dateFromComponents:previousMonthComponents];
    NSRange previousMonthDays = [_gregorian rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:previousMonthDate];
    NSInteger maxDate = previousMonthDays.length - weekdayBeginning;
    for (int i=0; i<weekdayBeginning; i++) {
        previousMonthComponents.day     = maxDate+i+1;
        NSInteger offsetX               = (_dayWidth*(i%7));
        NSInteger offsetY               = (_dayWidth *(i/7));
        UIButton *button                = [self dayButtonWithFrame:CGRectMake(_originX+offsetX, _originY + _dayWidth + offsetY, _dayWidth, _dayWidth)];
        
        [self configureDayButton:button withDate:[_gregorian dateFromComponents:previousMonthComponents]];
        [self addSubview:button];
    }
    //下个月
    if(remainingDays == 0)
        return ;
    NSDateComponents *nextMonthComponents = [_gregorian components:_dayInfoUnits fromDate:_calendarDate];
    nextMonthComponents.month ++;
    for (NSInteger i=remainingDays; i<7; i++) {
        nextMonthComponents.day         = (i+1)-remainingDays;
        NSInteger offsetX               = (_dayWidth*((i) %7));
        NSInteger offsetY               = (_dayWidth *((monthLength+weekdayBeginning)/7));
        UIButton *button                = [self dayButtonWithFrame:CGRectMake(_originX+offsetX, _originY + _dayWidth + offsetY, _dayWidth, _dayWidth)];
        [self configureDayButton:button withDate:[_gregorian dateFromComponents:nextMonthComponents]];
        [self addSubview:button];
    }
}
@end