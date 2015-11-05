//
//  TimerShaftCell.m
//  demo
//
//  Created by txbydev3 on 15/9/26.
//  Copyright © 2015年 txbydev3. All rights reserved.
//

#import "TimerShaftCell.h"
#import "TimerButton.h"

@implementation TimerShaftCell

/**
 *构造方法（初始化对象的时候会调用）
 *添加所需要的控件
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifer:(NSString *)reuseIdentifer cellHeight:(CGFloat)cellHeight row:(NSInteger)row{
    //用父类初始化
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifer];
    if (self) {
        NSLog(@"横竖轴线的长度：%f",cellHeight);
        // 1.时间竖轴线
        UIImageView *timeVerticalLine = [[UIImageView alloc] initWithFrame:CGRectMake(leftMargin, 0, 2, cellHeight)];
        [timeVerticalLine setImage:[UIImage imageNamed:@"time_vertical_line"]];
        [self.contentView addSubview:timeVerticalLine];
        /*** 设置横轴线根据竖轴线的高度动态变化 ***/
        // 2.时间横轴线
        UIImageView *timeHorizontalLine = [[UIImageView alloc] initWithFrame:CGRectMake(leftMargin, minCellHeight/2, cellHeight, 1)];
        [timeHorizontalLine setImage:[UIImage imageNamed:@"time_horizontal_line"]];
        [self.contentView addSubview:timeHorizontalLine];
        // 3.时间节点按钮
        UIButton *timeNodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(leftMargin+timeHorizontalLine.frame.size.width, timeHorizontalLine.frame.origin.y-nodeHeight/2, 20, 15)];
        timeNodeBtn.selected = NO;
        //按钮贴图
        [timeNodeBtn setImage:[UIImage imageNamed:@"time_node"] forState:UIControlStateNormal];
        [timeNodeBtn setImage:[UIImage imageNamed:@"time_node_delete"] forState:UIControlStateSelected];
        //按钮点击事件
        [timeNodeBtn addTarget:self action:@selector(deleteNode:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:timeNodeBtn];
        // 4.按钮组件
        _timerBtn = [[TimerButton alloc] initWithFrame:CGRectMake(leftBtnMargin, timeHorizontalLine.frame.origin.y-arrowHeight/2, leftMargin-leftBtnMargin, 70)];
        [self.contentView addSubview:_timerBtn];
        //为按钮组件中的日期按钮打上tag
        
    }
    return self;
}
/**
 * 用户删除节点事件
 */
- (void)deleteNode:(UIButton *)sender {
    //切换按钮选中状态
    sender.selected = !sender.selected;
    //提示询问用户是否确定删除
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@" " message:@"确定删除就诊记录吗？" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alertView show];
}
@end
