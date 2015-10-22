//
//  Visit.m
//  demo
//
//  Created by txbydev3 on 15/9/14.
//  Copyright (c) 2015年 txbydev3. All rights reserved.
//

#import "Visit.h"

@implementation Visit
/**
 *用字典初始化数据
 */
//- (id)initWithDict:(NSDictionary *)dict
//{
//    if (self = [super init]) {
//        [self setValuesForKeysWithDictionary:dict];
//    }
//    return self;
//}
//
//+ (id)VisitWithDict:(NSDictionary *)dict
//{
//    return [[self alloc] initWithDict:dict];
//}
+ (Visit *)visitInit {
    return [self init];
}
/**
 *无参数的构造函数
 */
- (Visit *)init {
    if (self = [super init]) {
        NSString *string = @"回访时间：";
        self.iconImage = @"IconImage.png";
        self.cellTitle = @"［回访纪录］";
        self.cellTime = [string stringByAppendingString:@"2015-9-13"];
        self.verticalLine = @"vertical.png";
        self.confirmLabel = @"已确认";
    }
    return self;
}
/**
 *带参数的构造函数
 */
- (instancetype)initWithIconImage:(NSString *)iconImage andCellTitle:(NSString *)cellTitle andCellTime:(NSString *)andVerticalLine andConfirmLabel:(NSString *)confirmLabel {
    return self;
}
@end
