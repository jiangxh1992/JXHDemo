//
//  VisitTableViewCell.h
//  demo
//
//  Created by txbydev3 on 15/9/14.
//  Copyright (c) 2015年 txbydev3. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Visit;
@class VisitCellFrame;

@interface VisitTableViewCell : UITableViewCell

/**
 *接收外界传入的模型
 */
@property (nonatomic, strong) Visit *visit;
@property (nonatomic, strong) VisitCellFrame *visitFrame;

@end
