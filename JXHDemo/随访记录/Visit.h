//
//  Visit.h
//  demo
//
//  Created by txbydev3 on 15/9/14.
//  Copyright (c) 2015年 txbydev3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Visit : NSObject
/**
 *visitcell的内容资源
 *此处声明默认为protected
 */
@property (nonatomic, copy) NSString *iconImage; //1.图标的图片资源
@property (nonatomic, copy) NSString *cellTitle; //2.标题的名称
@property (nonatomic, copy) NSString *cellTime; //3.时间参数
@property (nonatomic, copy) NSString *verticalLine; //4.竖直分割线的图片资源
@property (nonatomic, copy) NSString *confirmLabel; //5.确认标签内容
/**
 *用字典初始化数据
 */
//- (id)initWithDict:(NSDictionary *)dict;
//+ (id)VisitWithDict:(NSDictionary *)dict;

#pragma mark 带参数的构造函数
- (Visit *)initWithIconImage:(NSString *)iconImage andCellTitle:(NSString *)cellTitle andCellTime:(NSString *)andVerticalLine andConfirmLabel:(NSString *)confirmLabel;
#pragma mark init无参构造函数
- (Visit *)init;

+ (instancetype)visitInit;
@end
