//
//  ArticleCell.m
//  smh
//
//  Created by yh on 15/3/25.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import "ArticleCell.h"
#import "Paragraph.h"
#import "ArticleCellFrame.h"
#import "ESImageTool.h"

@interface ArticleCell()
{
    /**
     *  段落文字
     */
    UILabel *_contentLabel;
    
    /**
     *  段落图片
     */
    UIImageView *_imageView;
}
@end

@implementation ArticleCell

/**
 *  设置文章frame
 */
- (void)setCellFrame:(ArticleCellFrame *)cellFrame
{
    _cellFrame = cellFrame;
    Paragraph *paragraph = cellFrame.paragraph;
    
    if (paragraph.type == ESParagraphImage) // 图片
    {
        _imageView.hidden = NO;
        _contentLabel.hidden = YES;
        
        [ESImageTool downloadImage:paragraph.content imageView:_imageView];
        _imageView.frame = cellFrame.contentFrame;
    }
    else // 文本
    {
        _imageView.hidden = YES;
        _contentLabel.hidden = NO;
        
        _contentLabel.text = paragraph.content;
        _contentLabel.font = paragraph.font;
        _contentLabel.textColor = paragraph.color;
        _contentLabel.frame = cellFrame.contentFrame;
    }
}

/**
 *  创建
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        // 设置cell属性
        [self setupBg];
        
        // 添加子控件
        [self setupSubViews];
    }
    return self;
}

/**
 *  添加子控件
 */
- (void)setupSubViews
{
    // 内容
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.textColor = [UIColor grayColor];
    _contentLabel.numberOfLines = 0;
    _contentLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_contentLabel];
    
    // 配图
    _imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_imageView];
}

/**
 *  设置cell属性
 */
- (void)setupBg
{
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end