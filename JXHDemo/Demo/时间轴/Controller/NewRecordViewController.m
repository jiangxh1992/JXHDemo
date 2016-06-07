//
//  NewRecordViewController.m
//  demo
//
//  Created by jiangxh on 15/10/8.
//  Copyright © 2015年 txbydev3. All rights reserved.
//
#import "NewRecordViewController.h"
#import "TimerShaftTableViewController.h"
#import "NodeRecord.h"
#import "EditTypeViewController.h"

#pragma mark 宏定义新建时间节点页面的排版常量
//内容之间的间隔
#define padding 10
//字体的高
#define txtH 20
//内容与内容页面顶端的间距
#define marginTop ApplicationH/5
//复选框标签宽
#define checkLabelW 4*15
//复选框个数
#define checkBoxNum 7
//scrollview的高度,如果实际高度小于屏幕高度则设置为屏幕高度
#define realH 480 /*这个根据具体内容调整，保证scrollview里面的内容都可以显示出来*/
#define scrollH realH > ApplicationH ? realH : ApplicationH
//日期选择框追加按钮的高度
#define btnHeight 35
#define datePickerHeight 200

@interface NewRecordViewController ()<UITextViewDelegate, UIActionSheetDelegate, UIAlertViewDelegate>

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
 * 日期选择框的追加按钮
 */
@property (nonatomic,strong)UIButton *btnConfirm;

/**
 * 日期选择框选择的时间
 */
@property (nonatomic, strong)NSString *dateString;

/**
 * 时间格式
 */
@property (nonatomic ,strong)NSDateFormatter *dateFormatter;

/**
 * 使用药物输入框
 */
@property (nonatomic, strong)UITextView *medicineTextView;

/**
 * 过程评估输入框
 */
@property (nonatomic, strong)UITextView *feedbackTextView;

/**
 * 选择框选择的就诊类型
 */
@property (nonatomic, strong)NSString *typeString;

@end

@implementation NewRecordViewController

#pragma mark -lifecycle
/**
 * 视图加载
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.viewcontroller导航栏设置
    [self setNav];
    
    // 2.初始化视图变量
    [self viewInit];
    
    // 3.初始化可滑动的scrollview
    [self setScrollView];
    //将scrollview添加到内容页面中作为背景子页面同时承载纪录内容
    [self.view addSubview:self.recordScrollView];
    
    // 4.设置新节点内容到scrollview中
    [self setContent];
    
    // 5.注册键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark -private methods
/**
 *  视图导航栏设置
 */
- (void)setNav {
    //页面标题
    self.title = @"添加时间轴节点";
    //导航栏右侧发送按钮
    if ([_action isEqualToString:@"create"]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(commitNodeRecord)];
    } else {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更新" style:UIBarButtonItemStylePlain target:self action:@selector(commitNodeRecord)];
    }
    //页面背景色
    self.view.backgroundColor = [UIColor whiteColor];
}

/**
 * 初始化视图元素
 */
- (void)viewInit {
    _recordScrollView = [[UIScrollView alloc] init];
    _buttonInvisible  = [[UIButton alloc] init];
    _typeBtn          = [[UIButton alloc] init];
    _datePicker       = [[UIDatePicker alloc] init];
    _dateBtn          = [[UIButton alloc] init];
    _dateFormatter    = [[NSDateFormatter alloc] init];
    _medicineTextView = [[UITextView alloc] init];
    _feedbackTextView = [[UITextView alloc] init];
}

/**
 * 添加或者更新时间轴结点
 */
- (void)commitNodeRecord {
    // 制作最新结点
    NodeRecord *newNode = [[NodeRecord alloc] init];
    newNode.type = _typeString;// 结点类型
    newNode.date = _dateString;// 结点时间戳
    newNode.treat_progress = _medicineTextView.text;
    newNode.treat_estimate = _feedbackTextView.text;
    /* 告诉服务器添加或者更新结点 */
    // ... ...
    
    
    
    /* 本地数据只可以添加不可以编辑结点 */
    NSMutableArray *nodes;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:SLNodeRecordsDomainPath]) {
        NSMutableArray *domainArray = [[NSMutableArray alloc] initWithContentsOfFile:SLNodeRecordsDomainPath];
        nodes = [NodeRecord objectArrayWithKeyValuesArray:domainArray];
    }else {
        nodes = [NodeRecord objectArrayWithFilename:@"nodeRecord.plist"];
    }
    // 加入结点
    [nodes addObject:newNode];
    // 重新写入沙盒
    NSArray *domainArray = [NSArray keyValuesArrayWithObjectArray:nodes];
    [domainArray writeToFile:SLNodeRecordsDomainPath atomically:YES];
    //退出编辑界面回到时间轴,并刷新时间轴数据
    NSInteger index = [self.navigationController.viewControllers indexOfObject:self];
    TimerShaftTableViewController *timerVC = [self.navigationController.viewControllers objectAtIndex:index-1];
    // 刷新数据
    timerVC.isUpdate = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 * 初始化可滑动的scsrollview
 */
- (void)setScrollView {
    // 初始化frame
    _recordScrollView.frame = CGRectMake(0, 0, ApplicationW, scrollH);
    // 设置scrollview的内容尺寸，告诉设备scrollview可滚动的范围，否则不能滚动
    _recordScrollView.contentSize = CGSizeMake(ApplicationW, scrollH);
    // 不显示垂直滚动条
    _recordScrollView.showsVerticalScrollIndicator = NO;
    // 设置scrollview自动调整与superview的高度和宽度
    _recordScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    // scrollview中设置图片
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"doctor_my_dept_background"]];
    // 设置背景图片的尺寸跟scrollview的尺寸相同
    imageView.frame = _recordScrollView.frame;
    [_recordScrollView addSubview:imageView];
    // 添加隐形按钮覆盖在scrollview上,来弥补scrollview的UITouch触摸事件
    [_buttonInvisible setFrame:_recordScrollView.frame];
    // 添加按钮事件
    [_buttonInvisible addTarget:self action:@selector(withdrawKeyboard) forControlEvents:UIControlEventAllEvents];
    // 显示按钮子视图
    [_recordScrollView addSubview:_buttonInvisible];
}

/**
 * 设置内容
 */
- (void)setContent {
    // 1.1就诊类型标签
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SLMargin, marginTop, 5*txtH, txtH)];
    typeLabel.font = XHFontNormal;
    [typeLabel setText:@"诊断类型:"];
    [self.recordScrollView addSubview:typeLabel];
    
    // 1.2选择就诊类型按钮
    [_typeBtn setFrame:CGRectMake(SLMargin+typeLabel.frame.size.width, marginTop, 6*txtH, txtH)];
    //按钮占位文字
    [_typeBtn setTitle:@"点击选择" forState:UIControlStateNormal];
    //高亮
    _typeBtn.showsTouchWhenHighlighted = YES;
    //背景色
    _typeBtn.backgroundColor = [UIColor orangeColor];
    //打开类型选择框
    [_typeBtn addTarget:self action:@selector(openPickerView) forControlEvents:UIControlEventTouchUpInside];
    [_recordScrollView addSubview:_typeBtn];
    
    // 1.3添加编辑就诊类型按钮
    UIButton *editButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    // 设置中心位置
    editButton.center = CGPointMake(_typeBtn.frame.origin.x + _typeBtn.frame.size.width + editButton.frame.size.width/2+10, _typeBtn.frame.origin.y + _typeBtn.frame.size.height/2);
    // 按钮图片
    [editButton setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    // 设置事件
    [editButton addTarget:self action:@selector(editTypeSheet) forControlEvents:UIControlEventTouchUpInside];
    [_recordScrollView addSubview:editButton];
    
    // 2.1时间标签
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(SLMargin, typeLabel.frame.origin.y+typeLabel.frame.size.height+padding, 3*txtH, txtH)];
    dateLabel.font = XHFontNormal;
    [dateLabel setText:@"日期:"];
    [self.recordScrollView addSubview:dateLabel];
    
    // 2.2时间选择框picker
    //datepicker位置
    [_datePicker setFrame:CGRectMake(0, ApplicationH + btnHeight, ApplicationW, 0)];
    //日期选择框的背景颜色
    _datePicker.backgroundColor = [UIColor whiteColor];
    //添加到view上
    [self.view addSubview:_datePicker];
    //追加确定按钮
    _btnConfirm= [[UIButton alloc] initWithFrame:CGRectMake(0, ApplicationH, ApplicationW, btnHeight)];
    //按钮背景
    [_btnConfirm setBackgroundColor:RGBColor(200, 200, 200)];
    //按钮文字颜色
    [_btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //按钮文字
    [_btnConfirm setTitle:@"确认" forState:UIControlStateNormal];
    //按钮添加到view
    [self.view addSubview:_btnConfirm];
    //注册按钮事件
    [_btnConfirm addTarget:self action:@selector(closeDatePicker) forControlEvents:UIControlEventTouchUpInside];
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
    UILabel *medicineLabel = [[UILabel alloc] initWithFrame:CGRectMake(SLMargin, dateLabel.frame.origin.y+dateLabel.frame.size.height+padding, 5*txtH, txtH)];
    medicineLabel.font = XHFontNormal;
    [medicineLabel setText:@"治疗过程:"];
    [self.recordScrollView addSubview:medicineLabel];
    
    // 3.2使用药物输入框
    //诊断内容输入框的上边界线
    UIImageView *lineViewDignoseTop = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
    lineViewDignoseTop.frame = CGRectMake(SLMargin, medicineLabel.frame.origin.y+txtH+padding, ApplicationW-2*SLMargin, 1);
    [_recordScrollView addSubview:lineViewDignoseTop];
    [_medicineTextView setFrame:CGRectMake(SLMargin, medicineLabel.frame.origin.y+txtH+padding, ApplicationW-2*SLMargin, 3*txtH)];
    //输入框背景色
    _medicineTextView.backgroundColor = [UIColor clearColor];
    //输入框代理
    _medicineTextView.delegate = self;
    //将诊断输入框添加到内容页面中
    [self.recordScrollView addSubview:_medicineTextView];
    //诊断内容输入框的下边界线
    UIImageView *lineViewDignoseDown = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
    lineViewDignoseDown.frame = CGRectMake(SLMargin, _medicineTextView.frame.origin.y+_medicineTextView.frame.size.height, ApplicationW-2*SLMargin, 1);
    [_recordScrollView addSubview:lineViewDignoseDown];
    
    // 4.1过程评估标签
    UILabel *feedbackLabel = [[UILabel alloc] initWithFrame:CGRectMake(SLMargin, _medicineTextView.frame.origin.y+_medicineTextView.frame.size.height+padding, 5*txtH, txtH)];
    feedbackLabel.font = XHFontNormal;
    [feedbackLabel setText:@"过程评估:"];
    [self.recordScrollView addSubview:feedbackLabel];
    
    // 4.2过程评估输入框
    //诊断内容输入框的上边界线
    UIImageView *lineViewFeedbackTop = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
    lineViewFeedbackTop.frame = CGRectMake(SLMargin, feedbackLabel.frame.origin.y+txtH+padding, ApplicationW-2*SLMargin, 1);
    [_recordScrollView addSubview:lineViewFeedbackTop];
    [_feedbackTextView setFrame:CGRectMake(SLMargin, feedbackLabel.frame.origin.y+txtH+padding, ApplicationW-2*SLMargin, 3*txtH)];
    //输入框背景色
    _feedbackTextView.backgroundColor = [UIColor clearColor];
    //输入框代理
    _feedbackTextView.delegate = self;
    //将诊断输入框添加到内容页面中
    [self.recordScrollView addSubview:_feedbackTextView];
    //诊断内容输入框的下边界线
    UIImageView *lineViewFeedbackDown = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
    lineViewFeedbackDown.frame = CGRectMake(SLMargin, _feedbackTextView.frame.origin.y+_feedbackTextView.frame.size.height, ApplicationW-2*SLMargin, 1);
    [_recordScrollView addSubview:lineViewFeedbackDown];
}

/**
 *  编辑就诊类型选择框选项内容
 */
- (void)editTypeSheet {
    // 跳转到编辑类型视图控制器
    EditTypeViewController *editVC = [[EditTypeViewController alloc] init];
    [self.navigationController pushViewController:editVC animated:YES];
}

/**
 *  选择日期打开日期选择器
 */
- (void)openDatePciker {
    //计算页面的偏移量
    CGFloat offset = 74+_feedbackTextView.y+_feedbackTextView.height + 10 + btnHeight + datePickerHeight - ApplicationH;
    // 矫正不能为负
    if (offset<0) offset = 0;
    //datepicker从底部动画滑进屏幕
    [UIView animateWithDuration:0.5 animations:^{
        _recordScrollView.frame = CGRectMake(0, -offset, ApplicationW, scrollH);
        _btnConfirm.frame = CGRectMake(0, ApplicationH - datePickerHeight - btnHeight, ApplicationW, btnHeight);
        _datePicker.frame = CGRectMake(0, ApplicationH - datePickerHeight, ApplicationW, datePickerHeight);
    }];
}

/**
 *  关闭日期选择器
 */
- (void)closeDatePicker {
    //datepicker从屏幕滑出
    [UIView animateWithDuration:0.5 animations:^{
        _recordScrollView.frame = CGRectMake(0, 0, ApplicationW, scrollH);
        _datePicker.frame = CGRectMake(0, ApplicationH+btnHeight, ApplicationW, 0);
        _btnConfirm.frame = CGRectMake(0, ApplicationH, ApplicationW, btnHeight);
    }];
    //取时间
    _dateString = [_dateFormatter stringFromDate:_datePicker.date];
    [_dateBtn setTitle:_dateString forState:UIControlStateNormal];
}

/**
 *  打开类型选择器
 */
- (void)openPickerView {
    // 文件管理器实例
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 弹出框
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"就诊类型" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"自定义" otherButtonTitles:nil];
    // 如果沙盒数据存在则从沙盒取数据
    NSArray *diagnoseType;
    if ([fileManager fileExistsAtPath:SLDignoseTypeDomainPath]) {
        diagnoseType = [[NSArray alloc] initWithContentsOfFile:SLDignoseTypeDomainPath];
    } else {
        // 沙盒没有缓存,读取就诊类型数据(相当于请求一次)
        diagnoseType = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"diagnoseType" ofType:@"plist"]];
        // 写入沙盒
        [diagnoseType writeToFile:SLDignoseTypeDomainPath atomically:YES];
    }
    // 添加就诊选项按钮
    for (NSString *type in diagnoseType) {
        [sheet addButtonWithTitle:type];
    }
    [sheet showInView:self.view];
}

/**
 *  关闭键盘
 */
- (void)withdrawKeyboard {
    //隐藏键盘
    [self.view endEditing:YES];
}

#pragma mark - alertview delegate
/**
 *  自定义诊断类型
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        // 取出自定义诊断类型
        _typeString = [alertView textFieldAtIndex:0].text;
        //选择按钮显示选中的类型
        [_typeBtn setTitle:_typeString forState:UIControlStateNormal];
        // 新类型加入本地数据库
        NSMutableArray *dignoseType = [[NSMutableArray alloc] initWithContentsOfFile:SLDignoseTypeDomainPath];
        [dignoseType addObject:_typeString];
        // 重新写入沙盒
        [dignoseType writeToFile:SLDignoseTypeDomainPath atomically:YES];
    }
}

#pragma mark - actionsheet delegate
/**
 * 点击按钮的下标
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != actionSheet.cancelButtonIndex && buttonIndex != actionSheet.destructiveButtonIndex) {
        //取类型字符串
        _typeString = [actionSheet buttonTitleAtIndex:buttonIndex];
        //选择按钮显示选中的类型
        [_typeBtn setTitle:_typeString forState:UIControlStateNormal];
    }
    // 点击了自定义按钮
    if (buttonIndex == actionSheet.destructiveButtonIndex) {
        UIAlertView *newTypeDialog = [[UIAlertView alloc] initWithTitle:@"自定义诊断类型" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        // 普通输入类型
        [newTypeDialog setAlertViewStyle:UIAlertViewStylePlainTextInput];
        // 输入框
        UITextField *textFeild = [newTypeDialog textFieldAtIndex:0];
        // 键盘类型
        textFeild.keyboardType = UIKeyboardTypeDefault;
        // 提示信息
        textFeild.placeholder = @"诊断类型";
        [newTypeDialog show];
    }
}

#pragma mark -keyboard delegate
/**
 * 1.键盘显示事件
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
 * 2.键盘消失事件
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
 * 3.解除键盘事件通知
 */
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark uitextview delegate
/**
 * uitextview开始编辑的时候把它设置为当前textview（currenttextview）
 */
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    _currentTextView = textView;
    return YES;
}

@end