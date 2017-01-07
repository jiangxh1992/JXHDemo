//
//  DeviceInfoViewController.m
//  JXHDemo
//
//  Created by Xinhou Jiang on 7/1/17.
//  Copyright © 2017年 Jiangxh. All rights reserved.
//

#import "DeviceInfoViewController.h"

@interface DeviceInfoViewController ()

@end

@implementation DeviceInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"获取设备信息";
    
    // 1.UIDevice
    UIDevice *device = [UIDevice currentDevice]; // 获取当前的device
    
    /** 设备基本信息 **/
    NSString *name = [device name];// @"iPhone 5S"
    NSString *model = [device model];// @"iPhone"
    NSString *localizedModel = [device localizedModel];// @"iPhone"
    NSString *systemName = [device systemName];// @"iPhone OS"
    NSString *systemVersion = [device systemVersion];// @"9.3.2"
    NSLog(@"设备基本信息：\n%@\n%@\n%@\n%@\n%@", name, model,localizedModel,systemName,systemVersion);
    
    /** 设备方向 **/
    UIDeviceOrientation orientation = [device orientation]; // UIDeviceOrientationUnknown
    
    /** 设备ID **/
    NSUUID *identifierForVendor = [device identifierForVendor];
    
    // 2.NSBundle
    NSDictionary *info_dic = [[NSBundle mainBundle] infoDictionary]; // 获取当前设备的信息字典
    NSDictionary *localized_info_dic = [[NSBundle mainBundle] localizedInfoDictionary]; // 本地化的信息字典
    
    NSString *app_name = [info_dic objectForKey:@"CFBundleDisplayName"]; // 应用名称 @"Demo"
    NSString *app_version = [info_dic objectForKey:@"CFBundleShortVersionString"]; // 应用版本 @"1.0"
    NSString *app_build_version = [info_dic objectForKey:@"CFBundleVersion"]; // 应用build版本 @"1"
    NSLog(@"NSBundle：\n%@\n%@\n%@", app_name, app_version, app_build_version);

    
    // 3.NSLocale
    // 3.1 获取偏好语言
    NSArray *languageArray = [NSLocale preferredLanguages];
    NSString *language = [languageArray objectAtIndex:0]; // @"en_HK"
    
    // 3.2 获取本地化国家或地区代号
    NSLocale *locale = [NSLocale currentLocale]; // 当前本地化对象
    NSString *country = [locale localeIdentifier]; // @"en_HK"
}

@end
