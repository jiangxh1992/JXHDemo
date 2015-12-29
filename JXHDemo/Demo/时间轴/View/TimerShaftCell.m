//
//  TimerShaftCell.m
//  demo
//
//  Created by jiangxh on 15/9/26.
//  Copyright © 2015年 txbydev3. All rights reserved.
//

#import "TimerShaftCell.h"
#import "TimerButton.h"
#import "NodeRecord.h"

@implementation TimerShaftCell

/**
 * 构造方法（初始化对象的时候会调用,传进来结点数据模型）
 * 添加所需要的控件
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifer:(NSString *)reuseIdentifer nodeRecord:(NodeRecord *)nodeRecord{
    //用父类初始化
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifer];
    if (self) {
        // 1.时间竖轴线
        UIImageView *timeVerticalLine = [[UIImageView alloc] initWithFrame:CGRectMake(LMargin, 0, 2, nodeRecord.cellHeight)];
        [timeVerticalLine setImage:[UIImage imageNamed:@"time_vertical_line"]];
        [self.contentView addSubview:timeVerticalLine];
        /*** 设置横轴线根据竖轴线的高度动态变化 ***/
        // 2.时间横轴线
        UIImageView *timeHorizontalLine = [[UIImageView alloc] initWithFrame:CGRectMake(LMargin, minCellHeight/2, nodeRecord.cellHeight, 1)];
        [timeHorizontalLine setImage:[UIImage imageNamed:@"time_horizontal_line"]];
        [self.contentView addSubview:timeHorizontalLine];
        // 3.按钮组件
        _timerBtn = [[TimerButton alloc] initWithFrame:CGRectMake(leftBtnMargin, timeHorizontalLine.frame.origin.y-arrrowHeight/2, LMargin-leftBtnMargin, 70) nodeRecord:nodeRecord];
        [self.contentView addSubview:_timerBtn];
        //为按钮组件中的内容按钮打上tag
        _timerBtn.tag = nodeRecord.row;
        //添加内容按钮点击事件
        [_timerBtn.btnContent addTarget:self action:@selector(btnContentClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        // 4.时间节点删除按钮
        UIButton *timeNodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(LMargin+timeHorizontalLine.frame.size.width-5, timeHorizontalLine.frame.origin.y-nodeSize/2, nodeSize, nodeSize)];
        //按钮背景色,设置为跟按钮组件一样的颜色
        timeNodeBtn.backgroundColor = nodeRecord.nodeColor;
        //按钮边框色
        timeNodeBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        //边框宽度
        timeNodeBtn.layer.borderWidth = 1;
        timeNodeBtn.layer.cornerRadius = nodeSize/2;
        //为按钮组件中的内容按钮打上tag
        timeNodeBtn.tag = nodeRecord.row;
        //按钮点击事件
        [timeNodeBtn addTarget:self action:@selector(btnNodeClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:timeNodeBtn];
        //点击高亮
        timeNodeBtn.showsTouchWhenHighlighted = YES;
    }
    return self;
}
#pragma mark 按钮点击通知代理
/**
 * 5.按钮点击事件
 */
- (void)btnContentClicked:(UIButton *)sender {
    NSLog(@"日期内容按钮点击！%@",sender.titleLabel.text);
    [_delegate btnContentDidClicked:sender];
}
- (void)btnNodeClicked:(UIButton *)sender {
    //切换按钮选中状态
    sender.selected = !sender.selected;
    NSLog(@"日期删除节点按钮点击！");
    [_delegate btnNodeDidClicked:sender];
}

@end