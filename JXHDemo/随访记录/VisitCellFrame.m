//
//  VisitCellFrame.m
//  demo
//
//  Created by txbydev3 on 15/9/10.
//  Copyright (c) 2015年 txbydev3. All rights reserved.
//

#import "VisitCellFrame.h"
#import "Visit.h"

//cell的高度
#define cellHeight 80.0
//cell的padding
#define cellPaddding 10.0
//每一行内容的高度
#define contentSize 20.0 //(cellHeight-2.5*cellPadding)/2.0
//发送时间字体大小
#define fontSize 10.0

@implementation VisitCellFrame
+ (instancetype)VisitCellFrameInit {
    return [self init];
}
- (VisitCellFrame *)init{
    if (self = [super init]) {
        // 1.设置图标的frame
        self.iconF = CGRectMake(leftMargin, cellPaddding, contentSize, contentSize);
        // 2.设置title的frame
        self.titleF = CGRectMake(leftMargin+contentSize+cellPaddding/2.0, cellPaddding, 6*contentSize, contentSize);
        // 3.设置time的frame
        self.timeF = CGRectMake(leftMargin, cellPaddding+contentSize+cellPaddding/2.0, 10*contentSize, fontSize);
        // 4.设置verticalline的frame
        self.verticalLineF = CGRectMake(ApplicationW-4*contentSize, 0, contentSize/2.0, cellHeight);
        // 5.设置confirmlabel的frame
        self.confirmLabelF = CGRectMake(ApplicationW-3*contentSize, (cellHeight-contentSize)/2, 3*contentSize, contentSize);
    }
    
    return self;
}
@end
