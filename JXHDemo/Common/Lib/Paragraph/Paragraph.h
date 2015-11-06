//
//  Paragraph.h
//  smh
//
//  Created by yh on 15/3/25.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//  段落

typedef enum{
    ESParagraphTitle = 0,   // 标题
    ESParagraphTime = 1,    // 作者或时间
    ESParagraphContent = 3, // 内容
    ESParagraphImage = 4    // 图片
}ESParagraphType;

#import <Foundation/Foundation.h>

@interface Paragraph : NSObject

/**
 *  段落内容
 */
@property (nonatomic, copy) NSString *content;

/**
 *  段落类型
 */
@property (nonatomic, assign) ESParagraphType type;

/**
 *  段落字体
 */
@property (nonatomic, readonly) UIFont *font;

/**
 *  段落文字颜色
 */
@property (nonatomic, readonly) UIColor *color;

@end