//
//  TimerShaftCell.h
//  demo
//
//  Created by txbydev3 on 15/9/26.
//  Copyright © 2015年 txbydev3. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TimerButton;
@interface TimerShaftCell : UITableViewCell
/**
 * 日期按钮
 */
@property (nonatomic,strong)UIButton *timerBtn;
/**
 * 构造方法（初始化对象的时候会调用）
 * 添加所需要的控件
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifer:(NSString *)reuseIdentifer cellHeight:(CGFloat)cellHeight row:(NSInteger)row;
@end