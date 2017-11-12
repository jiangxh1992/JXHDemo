//
//  AudioRecordViewController.m
//  JXHDemo
//
//  Created by Xinhou Jiang on 30/10/2017.
//  Copyright © 2017 Jiangxh. All rights reserved.
//

#import "AudioRecordViewController.h"
#import "AudioRecord.h"

@interface AudioRecordViewController ()

@end

@implementation AudioRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [AudioRecord xh_AudioRecordInit];
}

- (IBAction)record:(id)sender {
    [AudioRecord xh_startOrResumeRecord];
}

- (IBAction)stop:(id)sender {
    [AudioRecord xh_stopRecord];
}

- (IBAction)play:(id)sender {
    [AudioRecord xh_playRecordedAudio];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
