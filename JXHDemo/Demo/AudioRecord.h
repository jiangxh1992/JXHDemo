//
//  AudioRecordViewController.h
//  JXHDemo
//
//  Created by Xinhou Jiang on 30/10/2017.
//  Copyright © 2017 Jiangxh. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioRecord:NSObject
// 录音文件绝对路径
@property (nonatomic, copy) NSString *filepathCaf;
// 录音机对象
@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
// 播放器对象，和上一章音频播放的方法相同，只不过这里简单播放即可
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;


+ (instancetype)Ins;
+ (void)xh_AudioRecordInit;
+ (void)xh_startOrResumeRecord;
+ (void)xh_pauseRecord;
+ (void)xh_stopRecord;
+ (void)xh_playRecordedAudio;
+ (float)xh_getVoicePower;
@end
