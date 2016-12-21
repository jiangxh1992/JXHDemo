//
//  SoundViewController.m
//  JXHDemo
//
//  Created by Xinhou Jiang on 21/12/16.
//  Copyright © 2016年 Jiangxh. All rights reserved.
//

#import "SoundViewController.h"
#import <AudioToolbox/AudioToolbox.h> // System Sound Service
#import <AVFoundation/AVFoundation.h>

// 定义sound的ID
static SystemSoundID system_sound_id_0 = 0;

@interface SoundViewController ()

@end

@implementation SoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 注册声音
    //[self registerSoundWithName:@"gameover" andID:system_sound_id_0];
    UIDevice *device = [[UIDevice alloc]init];
}

// 注册声音资源到系统
- (void) registerSoundWithName: (NSString *)name andID:(SystemSoundID)sound_id {
    // 1.获取音频文件url
    NSString *audioFile=[[NSBundle mainBundle] pathForResource:name ofType:@"wav"];
    NSURL *fileUrl=[NSURL fileURLWithPath:audioFile];
    // 2.将音效文件加入到系统音频服务中并返回一个长整形ID
    SystemSoundID SoundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &SoundID);
    // 3.注册一个播放完成回调函数
    AudioServicesAddSystemSoundCompletion(system_sound_id_0, NULL, NULL, soundCompleteCallback, NULL);
    
    AudioServicesPlaySystemSound(SoundID);
}

// 声音播放完成回调
void soundCompleteCallback(SystemSoundID sound_id,void *data) {
    // 声音已经播放完成
}

// 手机震动
- (IBAction)vibrate {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

// 播放短暂音频
- (IBAction)playShortMusic {
    //AudioServicesPlaySystemSound(system_sound_id_0);
    [self registerSoundWithName:@"snow" andID:system_sound_id_0];
}


@end
