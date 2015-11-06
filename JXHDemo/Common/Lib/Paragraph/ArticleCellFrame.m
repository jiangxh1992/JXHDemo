//
//  ArticleCellFrame.m
//  smh
//
//  Created by yh on 15/3/25.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import "ArticleCellFrame.h"
#import "Paragraph.h"
#import "NSString+Extension.h"

@implementation ArticleCellFrame

/**
 *  创建ArticleCellFrame
 */
+ (instancetype)cellFrameWithParagraph:(Paragraph *)paragraph
{
    ArticleCellFrame *cellFrame = [[ArticleCellFrame alloc] init];
    cellFrame.paragraph = paragraph;
    return cellFrame;
}

/**
 *  设置段落
 */
- (void)setParagraph:(Paragraph *)paragraph
{
    _paragraph = paragraph;
    
    if(paragraph.type == ESParagraphImage)
    {
        // 设置图片frame
        CGFloat imageX = CellMargin;
        CGFloat imageY = CellMargin;
        CGFloat imageW = ApplicationW - 2 * CellMargin;
        CGFloat imageH = 180;
        _contentFrame = CGRectMake(imageX, imageY, imageW, imageH);
    }
    else
    {
        // 设置内容frame
        CGFloat contentX = CellMargin;
        CGFloat contentY = CellMargin;
        CGFloat contentW = ApplicationW - 2 * CellMargin;
        CGFloat contentH = 100;
        //[paragraph.content sizeWithFont:paragraph.font maxSize:CGSizeMake(contentW, MAXFLOAT)].height;
        _contentFrame = CGRectMake(contentX, contentY, contentW, contentH);
    }
    
    // cell高度
    _cellHeight = CGRectGetMaxY(_contentFrame) + CellMargin;
}

@end