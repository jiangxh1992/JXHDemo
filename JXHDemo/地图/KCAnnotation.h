//
//  KCAnnotation.h
//  JXHDemo
//
//  Created by 919575700@qq.com on 10/16/15.
//  Copyright (c) 2015 Jiangxh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface KCAnnotation : NSObject<MKAnnotation>

/**
 *  二维地理坐标
 */
@property (nonatomic)CLLocationCoordinate2D centerCoordinate;
/**
 *  大头针的标题
 */
@property (nonatomic,copy)NSString *title;
/**
 *  大头针的副标题
 */
@property (nonatomic,copy)NSString *subTitle;
/**
 *  自定义一个图片属性在创建大头针视图时使用
 */
@property (nonatomic,strong) UIImage *image;

@end
