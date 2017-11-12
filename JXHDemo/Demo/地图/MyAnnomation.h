//
//  MyAnnomation.h
//  JXHDemo
//
//  Created by Xinhou Jiang on 18/10/2017.
//  Copyright © 2017 Jiangxh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MyAnnomation : NSObject

@property (nonatomic, copy) NSString *tag;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end
