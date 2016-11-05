//
//  AccountCell.m
//  JXHDemo
//
//  Created by Xinhou Jiang on 3/11/16.
//  Copyright © 2016年 Jiangxh. All rights reserved.
//
#define cellH 40 // cell高度
#define ApplicationW [UIScreen mainScreen].bounds.size.width // 屏幕宽度

#import "AccountCell.h"

@implementation AccountCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 头像
        _avatar = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, cellH-10, cellH-10)];
        _avatar.layer.cornerRadius = (cellH-10)/2;
        [self.contentView addSubview:_avatar];
        
        // 账号
        _name = [[UILabel alloc]initWithFrame:CGRectMake(cellH, 0, ApplicationW - cellH, cellH)];
        _name.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:_name];
    }
    
    return self;
}

@end
