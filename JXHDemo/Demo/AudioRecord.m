//
//  AudioRecordViewController.m
//  JXHDemo
//
//  Created by Xinhou Jiang on 30/10/2017.
//  Copyright © 2017 Jiangxh. All rights reserved.
//

#import "AudioRecord.h"

// 文件名
#define fileName_caf @"demoRecord.caf"

@interface AudioRecord () // 录音和播放器的代理选择性添加：<AVAudioRecorderDelegate,AVAudioPlayerDelegate>

@end

@implementation AudioRecord

+ (instancetype)Ins {
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (void)xh_AudioRecordInit {
    // 获取沙盒Document文件路径
    NSString *sandBoxPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 拼接录音文件绝对路径
    AudioRecord.Ins.filepathCaf = [sandBoxPath stringByAppendingPathComponent:fileName_caf];
    
    // 1.创建音频会话
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
    // 设置录音类别（这里选用录音后可回放录音类型）
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];

}

+ (void)xh_startOrResumeRecord {
    // 注意调用audiorecorder的get方法
    if (![AudioRecord.Ins.audioRecorder isRecording]) {
        // 如果该路径下的音频文件录制过则删除
        NSFileManager* fileManager=[NSFileManager defaultManager];
        if ([[NSFileManager defaultManager] fileExistsAtPath:AudioRecord.Ins.filepathCaf]) {
            // 文件已经存在
            if ([fileManager removeItemAtPath:AudioRecord.Ins.filepathCaf error:nil]) {
                NSLog(@"删除成功");
            }else {
                NSLog(@"删除失败");
            }
        }
        // 开始录音，会取得用户使用麦克风的同意
        [AudioRecord.Ins.audioRecorder record];
    }
}
+ (void)xh_pauseRecord {
    if (AudioRecord.Ins.audioRecorder) {
        [AudioRecord.Ins.audioRecorder pause];
    }
}
+ (void)xh_stopRecord {
    [AudioRecord.Ins.audioRecorder stop];
}
+ (void)xh_playRecordedAudio {
    // 没有文件不播放
    if (![[NSFileManager defaultManager] fileExistsAtPath:AudioRecord.Ins.filepathCaf]) return;
    // 播放最新的录音
    [AudioRecord.Ins.audioPlayer play];

}
+ (float)xh_getVoicePower {
    //更新声波值
    [AudioRecord.Ins.audioRecorder updateMeters];
    //第一个通道的音频，音频强度范围:[-160~0],这里调整到0~160
    float power = [AudioRecord.Ins.audioRecorder averagePowerForChannel:0] + 160;
    return power/160;
}

#pragma mark -录音设置工具函数
// 懒加载录音机对象get方法
- (AVAudioRecorder *)audioRecorder {
    if (!_audioRecorder) {
        // 保存录音文件的路径url
        NSURL *url = [NSURL URLWithString:_filepathCaf];
        // 创建录音格式设置setting
        NSDictionary *setting = [self getAudioSetting];
        // error
        NSError *error=nil;
        
        _audioRecorder = [[AVAudioRecorder alloc]initWithURL:url settings:setting error:&error];
        _audioRecorder.meteringEnabled = YES;// 监控声波
        if (error) {
            NSLog(@"创建录音机对象时发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioRecorder;
}

// audioPlayer懒加载getter方法
- (AVAudioPlayer *)audioPlayer {
    _audioRecorder = NULL; // 每次都创建新的播放器，删除旧的
    
    // 资源路径
    NSURL *url = [NSURL fileURLWithPath:_filepathCaf];
    
    // 初始化播放器，注意这里的Url参数只能为本地文件路径，不支持HTTP Url
    NSError *error = nil;
    _audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    
    //设置播放器属性
    _audioPlayer.numberOfLoops = 0;// 不循环
    _audioPlayer.volume = 0.5; // 音量
    [_audioPlayer prepareToPlay];// 加载音频文件到缓存【这个函数在调用play函数时会自动调用】
    
    if(error){
        NSLog(@"初始化播放器过程发生错误,错误信息:%@",error.localizedDescription);
        return nil;
    }
    
    return _audioPlayer;
}

// 录音设置
-(NSDictionary *)getAudioSetting{
    // LinearPCM 是iOS的一种无损编码格式,但是体积较为庞大
    // 录音设置信息字典
    NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] init];
    // 录音格式
    [recordSettings setValue :@(kAudioFormatLinearPCM) forKey: AVFormatIDKey];
    // 采样率
    [recordSettings setValue :@11025.0 forKey: AVSampleRateKey];
    // 通道数(双通道)
    [recordSettings setValue :@2 forKey: AVNumberOfChannelsKey];
    // 每个采样点位数（有8、16、24、32）
    [recordSettings setValue :@16 forKey: AVLinearPCMBitDepthKey];
    // 采用浮点采样
    [recordSettings setValue:@YES forKey:AVLinearPCMIsFloatKey];
    // 音频质量
    [recordSettings setValue:@(AVAudioQualityMedium) forKey:AVEncoderAudioQualityKey];
    // 其他可选的设置
    // ... ...
    
    return recordSettings;
}

@end
