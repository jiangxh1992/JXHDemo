//
//  JXHAlertView.m
//  JXHDemo
//
//  Created by 919575700@qq.com on 10/26/15.
//  Copyright (c) 2015 Jiangxh. All rights reserved.
//

#import "JXHAlertView.h"

@implementation JXHAlertView
@synthesize alertView;
/**
 *  结构初始化的时候改写UIView
 */
- (instancetype)initWithFrame:(CGRect)frame {
    //把父类UIView设置成屏幕大小
    if (self == [super initWithFrame:[UIScreen mainScreen].bounds]) {
        alertView = [[UIAlertView alloc] init];
        [self addSubview:alertView];
        return self;
    }else {
        return nil;
    }
}
- (instancetype)init {
    //把父类UIView设置成屏幕大小
    if (self == [super initWithFrame:[UIScreen mainScreen].bounds]) {
        return self;
    }else {
        return nil;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
