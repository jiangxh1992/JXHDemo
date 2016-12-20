//
//  AudioViewController.m
//  JXHDemo
//
//  Created by Xinhou Jiang on 20/12/16.
//  Copyright © 2016年 Jiangxh. All rights reserved.
//

#import "AudioViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface AudioViewController ()

@end

@implementation AudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:@"Vibrate" forState:UIControlStateNormal];
    button.center = CGPointMake(ApplicationW/2, ApplicationH/2);
    [button sizeToFit];
    button.backgroundColor = [UIColor orangeColor];
    [button addTarget:self action:@selector(vibrate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)vibrate {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
