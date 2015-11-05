//
//  TimerButton.m
//  demo
//
//  Created by txbydev3 on 15/9/27.
//  Copyright © 2015年 txbydev3. All rights reserved.
//
/**
 * 时间轴常量
 */
//最小的cell高度
#define minCellHeight 100.0
//最大的cell高度
#define maxCellHeight 180.0
//三角的宽度
#define arrowWidth 6
//三角的高度
#define arrowHeight 13
//node的高度
#define nodeHeight 15
//node的宽度
#define nodeWidth 20
//日期按钮与内容按钮之间的空隙
#define btnDistance 1
//时间轴与屏幕左边的边距
#define leftMargin 100
//按钮与屏幕左边间隔
#define leftBtnMargin 3
//时间轴按钮组件高度
#define timerBtnHeight minCellHeight
//日期按钮高度
#define dateBtnHeight 20
#import "TimerButton.h"
/**
 * 创建一个静态变量，保存动态变化的颜色下标，代替随机数生成颜色的方法
 * 不用初始化，默认已经是0
 */
static int colorIndex;
@interface TimerButton()<UIAlertViewDelegate>

@end
@implementation TimerButton
/**
 * 1.用frame结构来初始化按钮组件
 */
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _btnContent  = [[UIButton alloc] init];
        _btnDate     = [[UIButton alloc] init];
        _imgArrow    = [[UIImageView alloc] init];
        _btnSize     = frame.size;
        _MyColor     = [[NSMutableArray alloc] init];
        _Arrows      = [[NSMutableArray alloc] init];
        _random      = 0;
        
        //最外层按钮容器背景色
        self.backgroundColor = [UIColor clearColor];
        //设置自定义颜色库
        [self initMyColor];
        //随机取得主题颜色
        [self initRandomColor];
    }
    return self;
}
/**
 * 2.绘制按钮组件
 */
- (void)drawRect:(CGRect)rect {
    //假数据时间节点数组
    NSArray *nodeArray = @[@"2015-09-26",@"2015-09-20",@"2015-08-20",@"2015-08-15",@"2015-06-20",@"2015-06-10",@"2015-03-20",@"2015-02-13",@"2014-05-01"];
    //假数据复诊内容数组
    NSArray *contentArray = @[@"初诊",@"化疗",@"复诊",@"手术",@"体检",@"体检",@"体检",@"化疗",@"手术"];
    /** 1.绘制日期按钮 **/
    //尺寸
    [_btnDate setFrame:CGRectMake(0, 0, _btnSize.width-arrowWidth, 20)];
    //背景色
    _btnDate.backgroundColor = [_MyColor objectAtIndex:_random];
    //文字内容
    [_btnDate setTitle:[nodeArray objectAtIndex:_random] forState:UIControlStateNormal];
    //文字大小
    _btnDate.titleLabel.font = [UIFont systemFontOfSize:12];
    //文字颜色
    [_btnDate setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //点击高亮效果
    _btnDate.showsTouchWhenHighlighted = YES;
    //添加日期按钮点击事件
    [_btnDate addTarget:self action:@selector(btnDateClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    /** 2.绘制三角箭头 **/
    //尺寸
    [_imgArrow setFrame:CGRectMake(_btnDate.frame.size.width, 0, arrowWidth, arrowHeight)];
    [_imgArrow setImage:[UIImage imageNamed:[_Arrows objectAtIndex:_random]]];
    
    /** 3.绘制就诊内容按钮 **/
    //尺寸
    [_btnContent setFrame:CGRectMake(0, _btnDate.frame.size.height+btnDistance, _btnDate.frame.size.width, _btnSize.height-_btnDate.frame.size.height-btnDistance)];
    //背景色
    _btnContent.backgroundColor = [_MyColor objectAtIndex:_random];
    //文字内容
    [_btnContent setTitle:[contentArray objectAtIndex:_random] forState:UIControlStateNormal];
    //文字大小
    _btnContent.titleLabel.font = [UIFont systemFontOfSize:15];
    //文字颜色
    [_btnContent setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //点击高亮效果
    _btnContent.showsTouchWhenHighlighted = YES;
    //添加内容按钮点击事件
    [_btnContent addTarget:self action:@selector(btnContentClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    /** 4.子视图添加到父视图中 **/
    [self addSubview:_btnDate];
    [self addSubview:_btnContent];
    [self addSubview:_imgArrow];
}
/**
 * 3.设置自定义颜色库
 */
- (void)initMyColor {
    /**
     * 设置自定义颜色库
     */
    //浅灰色RGBColor(206,206,206)
    //橘红色RGBColor(229,186,140)
    //淡绿色RGBColor(212,228,162)
    //天蓝色RGBColor(162,210,228)
    //海蓝色RGBColor(162,178,228)
    //淡紫色RGBColor(174,162,228)
    //洋红色RGBColor(223,162,228)
    //粉红色RGBColor(228,162,167)
    [_MyColor addObject:RGBColor(206,206,206)];
    [_MyColor addObject:RGBColor(229,186,140)];
    [_MyColor addObject:RGBColor(212,228,162)];
    [_MyColor addObject:RGBColor(162,210,228)];
    [_MyColor addObject:RGBColor(162,178,228)];
    [_MyColor addObject:RGBColor(174,162,228)];
    [_MyColor addObject:RGBColor(223,162,228)];
    [_MyColor addObject:RGBColor(228,162,167)];
    /**
     * 设置相应三角按钮
     */
    [_Arrows addObject:@"timer_arrow0"];
    [_Arrows addObject:@"timer_arrow1"];
    [_Arrows addObject:@"timer_arrow2"];
    [_Arrows addObject:@"timer_arrow3"];
    [_Arrows addObject:@"timer_arrow4"];
    [_Arrows addObject:@"timer_arrow5"];
    [_Arrows addObject:@"timer_arrow6"];
    [_Arrows addObject:@"timer_arrow7"];
}
/**
 * 4.随机取得主题颜色
 */
- (void)initRandomColor {
    //颜色库里面的颜色数
    int colorCount = _MyColor.count;
    //求随机数
//    srand(time(0));
//    int random = arc4random()%colorCount;
//    NSLog(@"%d",random);
    //颜色下标＋1
    colorIndex++;
    colorIndex = colorIndex%colorCount;
    _random = colorIndex;
    NSLog(@"颜色下标：%d",colorIndex);
}
/**
 * 5.按钮点击事件
 */

- (void)btnDateClicked:(UIButton *)sender {
    NSLog(@"日期按钮点击！%@",sender.titleLabel.text);
    //通知代理按钮已经点击，可以打开详细内容页面了
    [_delegate btnDateDidClicked:sender];
}

- (void)btnContentClicked:(UIButton *)sender {
    NSString *msg = [NSString stringWithFormat:@"就诊类型：%@\n日期：2012.02.03\n使用药物：\nEmend，ZofranODT 等等\n过程评估：\n此次化疗效果显著，有效防止病情恶化.患者应维持药量，两周后再次化疗",sender.titleLabel.text];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"化疗记录" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    NSLog(@"日期内容按钮点击！%@",sender.titleLabel.text);
    [_delegate btnDateDidClicked:sender];
}
/**
 * 6.显示alertview时将其文本内容左对齐
 */
- (void)willPresentAlertView:(UIAlertView *)alertView {
    for(UIView * view in alertView.subviews) {
        if([view isKindOfClass:[UILabel class]]) {
            UILabel* label = (UILabel*) view;
           // label.textAlignment = UITextAlignmentLeft;
        }
        
    }
}
@end
