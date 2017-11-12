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
#import "MyAnnomation.h"

/**
 *  宏定义常量
 */
// 地图中心坐标
#define MapCenter CLLocationCoordinate2DMake(22.284160, 114.137603)
//地图显示范围
#define delta 0.01

@interface MapViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;         // 位置管理
@property (nonatomic, strong) MKMapView *mapView;                         // 定义一个MapView
@property (nonatomic, assign) CLLocationCoordinate2D initLocation;        // 初始位置
@property (nonatomic, strong) NSMutableArray *annomations;                // 大头针数据
@property (nonatomic, strong) NSMutableDictionary *mapIcons;              // 

@end

@implementation MapViewController
/**
 *  视图加载
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self request];
    
    //初始位置
    _initLocation = MapCenter;
    
    //地图设置
    [self setMapView];
    
    // 添加定位
    [self selfLocation];
    
    // 关闭按钮
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    closeBtn.backgroundColor = [UIColor redColor];
    closeBtn.titleLabel.text = @"关闭";
    [closeBtn addTarget:self action:@selector(closeMap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
}

/**
 * 初始化
 */
- (void)initData {
    _annomations = [[NSMutableArray alloc] init];
    _mapIcons = [[NSMutableDictionary alloc] init];
}

- (void)closeMap {
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
}

/**
 * 请求数据
 */
- (void)request {
    CLLocationCoordinate2D coords[5] = {CLLocationCoordinate2DMake(22.264160, 114.132603),CLLocationCoordinate2DMake(22.265050, 114.136603),CLLocationCoordinate2DMake(22.264160, 114.135503),CLLocationCoordinate2DMake(22.264160, 114.134683),CLLocationCoordinate2DMake(22.267169, 114.138503)};
    for(int i=0;i<5;++i){
        MyAnnomation *annom = [[MyAnnomation alloc] init];
        annom.tag = [NSString stringWithFormat:@"annomation%d",i];
        annom.title = @"Animal";
        annom.subtitle = @"catch me...";
        annom.coordinate = coords[i];
        annom.image = [NSString stringWithFormat:@"map_icon.bundle/map_icon%d.png",i];
        [_annomations addObject:annom];
        
        [_mapIcons setObject:annom.image forKey:annom.tag];
    }
}

/**
 *  地图设置
 */
- (void)setMapView {
    //设置地图位置
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, ApplicationW, ApplicationH - 64)];
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
 * 定位
 */
- (void) selfLocation {
    //创建定位对象
    
    _locationManager =[[CLLocationManager alloc] init];
    
    //设置定位属性
    
    _locationManager.desiredAccuracy =kCLLocationAccuracyBest;
    
    //设置定位更新距离militer
    
    _locationManager.distanceFilter=10.0;
    
    //绑定定位委托
    
    _locationManager.delegate=self;
    
    /**设置用户请求服务*/
    
    //1.去info.plist文件添加定位服务描述,设置的内容可以在显示在定位服务弹出的提示框
    
    //取出当前应用的定位服务状态(枚举值)
    
    CLAuthorizationStatus status =[CLLocationManager authorizationStatus];
    
    //如果未授权则请求
    
    if(status==kCLAuthorizationStatusNotDetermined) {
        
        [_locationManager requestAlwaysAuthorization];
    }
    
    //开始定位
    [_locationManager startUpdatingLocation];
}

/**
 *  添加大头针
 */
-(void)addAnnotation {
    for (MyAnnomation *annom in _annomations) {
        MKPointAnnotation *annotation=[[MKPointAnnotation alloc]init];
        [annotation setTitle:annom.title];
        [annotation setSubtitle:annom.tag];
        annotation.coordinate = annom.coordinate;
        [_mapView addAnnotation:annotation];
    }
}


/**
 * 代理提供自定义大头针视图
 */
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString *annokey = @"key";
    MKAnnotationView *annotationView=[_mapView dequeueReusableAnnotationViewWithIdentifier:annokey];
    if (!annotationView) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annokey];
        annotationView.canShowCallout = YES;
    }
    NSString *imagename = _mapIcons[annotation.subtitle];
    annotationView.image = [UIImage imageNamed:imagename];
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    NSLog(@"%@",userLocation.location);
}

@end
