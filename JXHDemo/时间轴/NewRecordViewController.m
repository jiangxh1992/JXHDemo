//
//  NewRecordViewController.m
//  demo
//
//  Created by txbydev3 on 15/10/8.
//  Copyright © 2015年 txbydev3. All rights reserved.
//
#pragma mark 宏定义新建时间节点页面的排版常量
//内容页面左右边距
#define margin 30
//内容之间的间隔
#define padding 10
//字体的高
#define txtH 20
//内容与内容页面顶端的间距
#define marginTop ApplicationH/5
//复选框宽度
#define checkSize 15
//复选框标签宽
#define checkLabelW 4*15
//复选框个数
#define checkBoxNum 7
//scrollview的高度,如果实际高度小于屏幕高度则设置为屏幕高度
#define realH 480 /*这个根据具体内容调整，保证scrollview里面的内容都可以显示出来*/
#define scrollH realH > ApplicationH ? realH : ApplicationH
//日期选择框的高度
#define datePickerHeight ApplicationH/4
//日期选择框追加按钮的高度
#define btnHeight 35
//日期选择框与追加按钮的间距
#define btnGap 50
#import "NewRecordViewController.h"
@interface NewRecordViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>

/**
 * 设置一个scrollview来承载,超出屏幕可滑动
 */
@property (nonatomic, strong)UIScrollView *recordScrollView;
/**
 * 设置一个跟scrollview一样大的透明按钮，来弥补scrollview的UITouch触摸事件
 */
@property (nonatomic, strong)UIButton *buttonInvisible;
/**
 * 选择就诊类型按钮
 */
@property (nonatomic, strong)UIButton *typeBtn;
/**
 *当前的textview，用来计算textview与键盘的距离及其位置随键盘调整
 */
@property (nonatomic, strong)UITextView *currentTextView;
/**
 * 显示时间的按钮
 */
@property (nonatomic, strong)UIButton *dateBtn;
/**
 * 日期选择框
 */
@property (nonatomic, strong)UIDatePicker *datePicker;
/**
 * 日期选择框选择的时间
 */
@property (nonatomic, strong)NSString *dateString;
/**
 * 时间格式
 */
@property (nonatomic ,strong)NSDateFormatter *dateFormatter;
/**
 * 日期选择框蒙板
 */
@property (nonatomic, strong)UIButton *btnSheild;
/**
 * 使用药物输入框
 */
@property (nonatomic, strong)UITextView *medicineTextView;
/**
 * 过程评估输入框
 */
@property (nonatomic, strong)UITextView *feedbackTextView;
/**
 * 选择框视图
 */
@property (nonatomic, strong)UIPickerView *pickerView;
/**
 * 选择框内容数组
 */
@property (nonatomic, strong)NSArray *pickerContent;
/**
 * 选择框选择的就诊类型
 */
@property (nonatomic, strong)NSString *typeString;

@end

@implementation NewRecordViewController
/**
 * 0.视图加载
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.viewcontroller导航栏设置
    //页面标题
    self.title = @"添加时间轴节点";
    //导航栏右侧发送按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addRecord)];
    //页面背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 2.初始化视图变量
    [self viewInit];
    
    // 初始化可滑动的scrollview
    [self setScrollView];
    //将scrollview添加到内容页面中作为背景子页面同时承载纪录内容
    [self.view addSubview:self.recordScrollView];
    
    // 4.设置新节点内容到scrollview中
    [self setContent];
    
    // 5.注册键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
/**
 * 1.初始化视图元素
 */
- (void)viewInit {
    _recordScrollView = [[UIScrollView alloc] init];
    _buttonInvisible  = [[UIButton alloc] init];
    _typeBtn          = [[UIButton alloc] init];
    _datePicker       = [[UIDatePicker alloc] init];
    _dateBtn          = [[UIButton alloc] init];
    _dateFormatter    = [[NSDateFormatter alloc] init];
    _btnSheild        = [[UIButton alloc] init];
    _medicineTextView = [[UITextView alloc] init];
    _feedbackTextView = [[UITextView alloc] init];
    _pickerView       = [[UIPickerView alloc] init];
    _pickerContent    = [[NSArray alloc] initWithObjects:@"初诊",@"复诊",@"手术",@"化疗",@"体检", nil];
}
/**
 * 2.将新节点加入时间轴
 */
- (void)addRecord {
    //就诊类型
        //_typeString
    //就诊时间
        //_dateString
    //使用药物
    NSString *medicineContent = _medicineTextView.text;
    //过程评价
    NSString *feedbackContent = _feedbackTextView.text;
}

/**
 * 自定义函数
 * 3.初始化可滑动的scsrollview
 */
- (void)setScrollView {
    //初始化frame
    _recordScrollView.frame = CGRectMake(0, 0, ApplicationW, scrollH);
    //设置scrollview的内容尺寸，告诉设备scrollview可滚动的范围，否则不能滚动
    _recordScrollView.contentSize = CGSizeMake(ApplicationW, scrollH);
    //不显示垂直滚动条
    _recordScrollView.showsVerticalScrollIndicator = NO;
    //设置scrollview自动调整与superview的高度和宽度
    _recordScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    //scrollview中设置图片
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"doctor_my_dept_background.png"]];
    //设置背景图片的尺寸跟scrollview的尺寸相同
    imageView.frame = _recordScrollView.frame;
    [_recordScrollView addSubview:imageView];
    
    //添加隐形按钮覆盖在scrollview上,来弥补scrollview的UITouch触摸事件
    [_buttonInvisible setFrame:_recordScrollView.frame];
    //添加按钮事件
    [_buttonInvisible addTarget:self action:@selector(withdrawKeyboard) forControlEvents:UIControlEventAllEvents];
    //显示按钮子视图
    [_recordScrollView addSubview:_buttonInvisible];
}
#pragma mark 设置内容
/**
 * 自定义函数
 * 4.设置内容
 */
- (void)setContent {
    // 1.1就诊类型标签
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, marginTop, 5*txtH, txtH)];
    [typeLabel setText:@"诊断类型:"];
    [self.recordScrollView addSubview:typeLabel];
    
    // 1.2选择就诊类型按钮
    [_typeBtn setFrame:CGRectMake(margin+typeLabel.frame.size.width, marginTop, 6*txtH, txtH)];
    //按钮占位文字
    [_typeBtn setTitle:@"点击选择" forState:UIControlStateNormal];
    //高亮
    _typeBtn.showsTouchWhenHighlighted = YES;
    //背景色
    _typeBtn.backgroundColor = [UIColor orangeColor];
    //打开类型选择框
    [_typeBtn addTarget:self action:@selector(openPickerView) forControlEvents:UIControlEventTouchUpInside];
    [_recordScrollView addSubview:_typeBtn];
    
    // 2.1时间标签
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, typeLabel.frame.origin.y+typeLabel.frame.size.height+padding, 3*txtH, txtH)];
    [dateLabel setText:@"日期:"];
    [self.recordScrollView addSubview:dateLabel];
    
    // 2.2时间选择框picker
    //位置
    _datePicker.center = CGPointMake(ApplicationW/2, ApplicationH/2);
    //日期选择框的背景颜色
    //_datePicker.backgroundColor = [UIColor whiteColor];
    //设置选择框的类型:只显示年月日
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    //设置中文时间选择器
    [_datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"]];
    //定义时间显示格式
    [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //获取时间字符串
    _dateString = [_dateFormatter stringFromDate:_datePicker.date];
    //显示时间选择器
    //选择日期按钮
    [_dateBtn setFrame:CGRectMake(_typeBtn.frame.origin.x, dateLabel.frame.origin.y, _typeBtn.frame.size.width, txtH)];
    //按钮显示当前时间
    [_dateBtn setTitle:_dateString forState:UIControlStateNormal];
    //高亮
    _dateBtn.showsTouchWhenHighlighted = YES;
    //按钮背景色
    _dateBtn.backgroundColor = [UIColor orangeColor];
    //按钮事件
    [_dateBtn addTarget:self action:@selector(openDatePciker) forControlEvents:UIControlEventTouchUpInside];
    [_recordScrollView addSubview:_dateBtn];
    
    // 3.1使用药物标签
    UILabel *medicineLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, dateLabel.frame.origin.y+dateLabel.frame.size.height+padding, 5*txtH, txtH)];
    [medicineLabel setText:@"使用药物:"];
    [self.recordScrollView addSubview:medicineLabel];
    // 3.2使用药物输入框
    //诊断内容输入框的上边界线
    UIImageView *lineViewDignoseTop = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
    lineViewDignoseTop.frame = CGRectMake(margin, medicineLabel.frame.origin.y+txtH+padding, ApplicationW-2*margin, 1);
    [_recordScrollView addSubview:lineViewDignoseTop];
    //--------------------------------------------------------------------------------------------------------------
    [_medicineTextView setFrame:CGRectMake(margin, medicineLabel.frame.origin.y+txtH+padding, ApplicationW-2*margin, 3*txtH)];
    //输入框边框的宽度
    //_dignoseTextView.layer.borderWidth = 1;
    //输入框背景色
    _medicineTextView.backgroundColor = [UIColor clearColor];
    //输入框边框的颜色
    //_dignoseTextView.layer.borderColor = [[UIColor grayColor]CGColor];
    //输入框圆角
    //dignoseTextView.layer.cornerRadius = 5;
    //输入框代理
    _medicineTextView.delegate = self;
    //将诊断输入框添加到内容页面中
    [self.recordScrollView addSubview:_medicineTextView];
    //--------------------------------------------------------------------------------------------------------------
    //诊断内容输入框的下边界线
    UIImageView *lineViewDignoseDown = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
    lineViewDignoseDown.frame = CGRectMake(margin, _medicineTextView.frame.origin.y+_medicineTextView.frame.size.height, ApplicationW-2*margin, 1);
    [_recordScrollView addSubview:lineViewDignoseDown];

    
    // 4.1过程评估标签
    UILabel *feedbackLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, _medicineTextView.frame.origin.y+_medicineTextView.frame.size.height+padding, 5*txtH, txtH)];
    [feedbackLabel setText:@"过程评估:"];
    [self.recordScrollView addSubview:feedbackLabel];
    // 4.2过程评估输入框
    //诊断内容输入框的上边界线
    UIImageView *lineViewFeedbackTop = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
    lineViewFeedbackTop.frame = CGRectMake(margin, feedbackLabel.frame.origin.y+txtH+padding, ApplicationW-2*margin, 1);
    [_recordScrollView addSubview:lineViewFeedbackTop];
    //--------------------------------------------------------------------------------------------------------------
    [_feedbackTextView setFrame:CGRectMake(margin, feedbackLabel.frame.origin.y+txtH+padding, ApplicationW-2*margin, 3*txtH)];
    //输入框背景色
    _feedbackTextView.backgroundColor = [UIColor clearColor];
    //输入框代理
    _feedbackTextView.delegate = self;
    //将诊断输入框添加到内容页面中
    [self.recordScrollView addSubview:_feedbackTextView];
    //--------------------------------------------------------------------------------------------------------------
    //诊断内容输入框的下边界线
    UIImageView *lineViewFeedbackDown = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
    lineViewFeedbackDown.frame = CGRectMake(margin, _feedbackTextView.frame.origin.y+_feedbackTextView.frame.size.height, ApplicationW-2*margin, 1);
    [_recordScrollView addSubview:lineViewFeedbackDown];
}
#pragma mark 打开日期选择器
/**
 * 5.1选择日期打开日期选择器
 */
- (void)openDatePciker {
    //用按钮制作一个半透明灰色蒙板
    [_btnSheild setFrame:self.view.frame];
    _btnSheild.backgroundColor = [UIColor whiteColor];
    //确定按钮
    UIButton *btnConfirm = [[UIButton alloc] initWithFrame:CGRectMake(0, _datePicker.frame.origin.y+_datePicker.frame.size.height+5, ApplicationW, 25)];
    //按钮背景
    //[btnConfirm setBackgroundColor:[UIColor whiteColor]];
    //按钮文字颜色
    [btnConfirm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //按钮文字
    [btnConfirm setTitle:@"确认" forState:UIControlStateNormal];
    //注册按钮事件
    [btnConfirm addTarget:self action:@selector(closeDatePicker) forControlEvents:UIControlEventTouchUpInside];
    //蒙板添加到scrollview
    [_recordScrollView addSubview:_btnSheild];
    //datepicker和确认按钮添加到蒙板上
    [_btnSheild addSubview:btnConfirm];
    [_btnSheild addSubview:_datePicker];
}
/**
 * 5.2关闭日期选择器
 */
- (void)closeDatePicker {
    //移除蒙板及其子视图
    [_btnSheild removeFromSuperview];
    [_datePicker removeFromSuperview];
    //取时间
    _dateString = [_dateFormatter stringFromDate:_datePicker.date];
    [_dateBtn setTitle:_dateString forState:UIControlStateNormal];
}
#pragma mark 打开类型选择框视图
/**
 * 6.1打开类型选择器
 */
- (void)openPickerView {
    //选择框视图delegate代理
    _pickerView.delegate = self;
    //选择视图datesource
    _pickerView.dataSource = self;
    //[_pickerView setFrame:CGRectMake(0, 0, ApplicationW, ApplicationH/6)];
    _pickerView.center = CGPointMake(ApplicationW/2, ApplicationH/2);
    
    //用按钮制作一个半透明灰色蒙板
    [_btnSheild setFrame:self.view.frame];
    _btnSheild.backgroundColor = [UIColor whiteColor];
    //确定按钮
    UIButton *btnConfirm = [[UIButton alloc] initWithFrame:CGRectMake(0, _datePicker.frame.origin.y+_datePicker.frame.size.height+5, ApplicationW, 25)];
    //按钮背景
    //[btnConfirm setBackgroundColor:[UIColor whiteColor]];
    //按钮文字颜色
    [btnConfirm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //按钮文字
    [btnConfirm setTitle:@"确认" forState:UIControlStateNormal];
    //注册按钮事件
    [btnConfirm addTarget:self action:@selector(closePickerView) forControlEvents:UIControlEventTouchUpInside];
    //蒙板添加到scrollview
    [_recordScrollView addSubview:_btnSheild];
    //datepicker和确认按钮添加到蒙板上
    [_btnSheild addSubview:btnConfirm];
    [_btnSheild addSubview:_pickerView];
}
/**
 * 6.2关闭类型选择器
 */
- (void)closePickerView {
    //移除蒙板及其子视图
    [_btnSheild removeFromSuperview];
    [_pickerView removeFromSuperview];
    //选择的行数
    NSInteger rowSelected = [_pickerView selectedRowInComponent:0];
    //取类型字符串
    _typeString = [_pickerContent objectAtIndex:rowSelected];
    //选择按钮显示选中的类型
    [_typeBtn setTitle:_typeString forState:UIControlStateNormal];
}
#pragma mark pickerView代理事件
/**
 * 6.3选择框的列数
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
/**
 * 6.4选择框每列的行数
 */
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _pickerContent.count;
}
/**
 * 6.5选择框每列的内容
 */
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_pickerContent objectAtIndex:row];
}

/**
 * 自定义函数
 * 7.关闭键盘
 */
- (void)withdrawKeyboard {
    //隐藏键盘
    [self.view endEditing:YES];
}
#pragma mark - 键盘事件
/**
 * 7.1键盘显示事件
 */
- (void)keyboardWillShow:(NSNotification *)notification
{
    // 键盘与输入框的距离
    CGFloat INTERVAL_KEYBOARD = 10;
    // 获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    // 计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    CGFloat offset = 74+_currentTextView.frame.origin.y+_currentTextView.frame.size.height+INTERVAL_KEYBOARD+kbHeight - ApplicationH;
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            _recordScrollView.frame = CGRectMake(0, -offset, ApplicationW, scrollH);
        }];
    }
}

/**
 * 7.2键盘消失事件
 */
- (void)keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        _recordScrollView.frame = CGRectMake(0, 0, ApplicationW, scrollH);
    }];
}
/**
 * 7.3解除键盘事件通知
 */
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark uitextview代理事件处理
/**
 * 8.uitextview开始编辑的时候把它设置为当前textview（currenttextview）
 */
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    _currentTextView = textView;
    return YES;
}

@end
