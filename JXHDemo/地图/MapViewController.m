//
//  MapViewController.m
//  Demo
//
//  Created by 919575700@qq.com on 10/15/15.
//  Copyright (c) 2015 Jiangxh. All rights reserved.
//
#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "KCAnnotation.h"
/**
 *  宏定义常量
 */
//经度
#define latitude 31.338928
//纬度
#define longitude 120.613353
//地图显示范围
#define delta 0.5

@interface MapViewController ()<MKAnnotation,MKMapViewDelegate>

/**
 *  位置管理
 */
@property (nonatomic)CLLocationManager *locationManager;
/**
 *  定义一个MapView
 */
@property (nonatomic) MKMapView *mapView;
/**
 *  初始位置
 */
@property (nonatomic) CLLocationCoordinate2D initLocation;

@end

@implementation MapViewController
/**
 *  视图加载
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始位置
    _initLocation = CLLocationCoordinate2DMake(latitude, longitude);
    //地图设置
    [self setMapView];
}
/**
 *  地图设置
 */
- (void)setMapView {
    //设置地图位置
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 30, ApplicationW, ApplicationH - 30)];
    //设置代理
    _mapView.delegate = self;
    //设置地图可缩放
    [_mapView setZoomEnabled:YES];
    //设置可滚动
    [_mapView setScrollEnabled:YES];
    //设置地图模式
    [_mapView setMapType : MKMapTypeStandard];
    //定义显示的范围
    MKCoordinateSpan theSpan;
    theSpan.latitudeDelta = delta;
    theSpan.longitudeDelta = delta;
    //定义一个区域（用定义的经纬度和范围来定义）
    MKCoordinateRegion theRegion;
    theRegion.center = _initLocation;
    theRegion.span = theSpan;
    //在地图上显示自定义区域
    [_mapView setRegion:theRegion];
    //添加地图
    [self.view addSubview : _mapView];
    //添加大头针
    [self addAnnotation];
}

/**
 *  添加大头针
 */
-(void)addAnnotation{
    MKPointAnnotation *annotation=[[MKPointAnnotation alloc]init];
    annotation.coordinate = _initLocation;
    [annotation setTitle:@"苏大附一"];
    [annotation setSubtitle:@"苏州大学附属医院"];
    [_mapView addAnnotation:annotation];
}

@end
