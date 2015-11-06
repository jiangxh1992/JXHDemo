//
//  Paragraph.m
//  smh
//
//  Created by yh on 15/3/25.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import "Paragraph.h"

@implementation Paragraph

/**
 *  设置段落类型
 */
- (void)setType:(ESParagraphType)type
{
    _type = type;
    
    if (type == ESParagraphTitle) // 标题
    {
        _font = [UIFont systemFontOfSize:18];
        _color = [UIColor blackColor];
    }
    else if (type == ESParagraphTime) // 时间
    {
        _font = [UIFont systemFontOfSize:15];
        _color = [UIColor grayColor];
    }
    else if (type == ESParagraphContent) // 内容
    {
        _font = [UIFont systemFontOfSize:16];
        _color = [UIColor darkGrayColor];
    }
}

@end