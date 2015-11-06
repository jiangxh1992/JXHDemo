//
//  ArticleCellFrame.h
//  smh
//
//  Created by yh on 15/3/25.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//  文章frame

#import <Foundation/Foundation.h>
@class Paragraph;

@interface ArticleCellFrame : NSObject

/**
 *  段落
 */
@property (nonatomic, strong) Paragraph *paragraph;

/**
 *  cell高度
 */
@property (nonatomic, readonly) CGFloat cellHeight;

/**
 *  内容frame
 */
@property (nonatomic, readonly) CGRect contentFrame;

/**
 *  创建ArticleCellFrame
 */
+ (instancetype)cellFrameWithParagraph:(Paragraph *)paragraph;

@end