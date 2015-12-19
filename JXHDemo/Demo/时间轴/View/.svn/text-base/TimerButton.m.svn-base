//
//  TimerButton.m
//  demo
//
//  Created by jiangxh on 15/9/27.
//  Copyright © 2015年 txbydev3. All rights reserved.
//

#import "TimerButton.h"
#import "NodeRecord.h"

@interface TimerButton()<UIAlertViewDelegate>

@end

@implementation TimerButton

/**
 * 1.用frame结构和所在cell行数来初始化按钮组件
 */
- (id)initWithFrame:(CGRect)frame nodeRecord:(NodeRecord *)nodeRecord {
    if (self = [super initWithFrame:frame]) {
        _nodeRecord = nodeRecord;
        _btnContent  = [[UIButton alloc] init];
        _btnDate     = [[UIButton alloc] init];
        _imgArrow    = [[UIImageView alloc] init];
        _btnSize     = frame.size;
        // 最外层按钮容器背景色
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

/**
 * 2.绘制按钮组件
 */
- (void)drawRect:(CGRect)rect {
    /** 1.绘制日期按钮 **/
    // 尺寸
    [_btnDate setFrame:CGRectMake(0, 0, _btnSize.width-arrrowWidth, 20)];
    // 背景色
    _btnDate.backgroundColor = _nodeRecord.nodeColor;
    // 文字大小
    _btnDate.titleLabel.font = [UIFont systemFontOfSize:12];
    // 文字颜色
    [_btnDate setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    /** 2.绘制三角箭头 **/
    // 尺寸
    [_imgArrow setFrame:CGRectMake(_btnDate.frame.size.width, 0, arrrowWidth, arrrowHeight)];
    [_imgArrow setImage:[UIImage imageNamed:_nodeRecord.arrowName]];
    /** 3.绘制就诊内容按钮 **/
    // 尺寸
    [_btnContent setFrame:CGRectMake(0, _btnDate.frame.size.height+btnDistance, _btnDate.frame.size.width, _btnSize.height-_btnDate.frame.size.height-btnDistance)];
    // 背景色
    _btnContent.backgroundColor = _nodeRecord.nodeColor;
    // 文字大小
    _btnContent.titleLabel.font = [UIFont systemFontOfSize:15];
    // 文字颜色
    [_btnContent setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    // 点击高亮效果
    _btnContent.showsTouchWhenHighlighted = YES;
    /** 4.子视图添加到父视图中 **/
    [self addSubview:_btnDate];
    [self addSubview:_btnContent];
    [self addSubview:_imgArrow];
}

@end