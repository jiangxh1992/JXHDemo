//
//  VisitTableViewCell.m
//  demo
//
//  Created by txbydev3 on 15/9/14.
//  Copyright (c) 2015年 txbydev3. All rights reserved.
//

#import "VisitTableViewCell.h"
#import "Visit.h"
#import "VisitCellFrame.h"

//cell的高度
#define cellHeight 80.0
//cell的padding
#define cellPaddding 10.0
//cell左边的margin
#define leftMargin 20.0
//每一行内容的高度
#define contentSize 20.0 //(cellHeight-2.5*cellPadding)/2.0
//发送时间字体大小
#define fontSize 10.0

@interface VisitTableViewCell ()
/**
 *cell图标
 */
@property (nonatomic, weak)UIImageView *iconImage;
/**
 *cell标题
 */
@property (nonatomic, weak)UILabel *cellTitle;
/**
 *时间
 */
@property (nonatomic, weak)UILabel *cellTime;
/**
 *竖直分割线
 */
@property (nonatomic, weak)UIImageView *verticalLine;
/**
 *确认标签
 */
@property (nonatomic, weak)UILabel *confirmLabel;

@end

@implementation VisitTableViewCell
/**
 *构造方法（初始化对象的时候会调用）
 *添加所需要的控件
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    //导入模型
    Visit *visit = [[Visit alloc] init];
    VisitCellFrame *frame = [[VisitCellFrame  alloc] init];
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //让自定义的cell和系统的cell一样
        //1.创建cell图标
        UIImageView *iconImage = [[UIImageView alloc]initWithFrame:frame.iconF];
        [iconImage setImage:[UIImage imageNamed:visit.iconImage]];//加载图片资源
        self.iconImage = iconImage;
        [self.contentView addSubview:iconImage];
        
        //2.创建标题
        UILabel *cellTitle = [[UILabel alloc] initWithFrame:frame.titleF];
        cellTitle.text = visit.cellTitle;//标签内容
        cellTitle.textColor = [UIColor redColor];//标题的颜色
        cellTitle.font = [UIFont fontWithName:@"黑体" size:contentSize];//字体
        self.cellTitle = cellTitle;
        [self.contentView addSubview:cellTitle];
        
        //3.创建时间
        UILabel *cellTime = [[UILabel alloc]initWithFrame:frame.timeF];
        cellTime.text = visit.cellTime;//标签内容
        cellTime.font = [UIFont fontWithName:@"黑体" size:fontSize];//字体
        self.cellTime = cellTitle;
        [self.contentView addSubview:cellTime];
        
        //4.创建分割线
        UIImageView *verticalLine = [[UIImageView alloc]initWithFrame:frame.verticalLineF];
        [verticalLine setImage:[UIImage imageNamed:visit.verticalLine]];//加载图片资源
        self.verticalLine = verticalLine;
        [self.contentView addSubview:verticalLine];
        
        //5.创建确认标签
        UILabel *confirmLabel = [[UILabel alloc]initWithFrame:frame.confirmLabelF];
        confirmLabel.text = visit.confirmLabel;//标签内容
        confirmLabel.textColor = [UIColor orangeColor];//标题的颜色
        confirmLabel.font = [UIFont fontWithName:@"黑体" size:contentSize];//字体
        self.confirmLabel = confirmLabel;
        [self.contentView addSubview:confirmLabel];
    }
    return self;
}

/**
 *设置table结构
 */
- (void)setframe:(VisitCellFrame *)frame {
    //1.给子控件赋值数据
    [self setData];
    //2.设置frame
}
/**
 *给子控件赋值数据
 */
- (void)setData {
    
}
/**
 *设置frame
 */
- (void)setFrame {
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
