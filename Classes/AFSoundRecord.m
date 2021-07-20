//
//  AFSoundRecord.m
//  AFSoundManager-Demo
//
//  Created by Alvaro Franco on 10/02/15.
//  Copyright (c) 2015 AlvaroFranco. All rights reserved.
//

#import "AFSoundRecord.h"
#import <AVFoundation/AVFoundation.h>

@interface AFSoundRecord ()<AVAudioRecorderDelegate>

@property (nonatomic, strong) AVAudioRecorder *recorder;

@end

@implementation AFSoundRecord

-(id)initWithFilePath:(NSString *)filePath {
    if (self == [super init]) {
        AVAudioSession *session =[AVAudioSession sharedInstance];
        NSError *sessionError;
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
        if (session == nil) {
            NSLog(@"Error creating session: %@",[sessionError description]);
        }else{
            [session setActive:YES error:nil];
        }
        // setting:录音的设置项
        NSDictionary *configDic = @{// 编码格式
                                    AVFormatIDKey:@(kAudioFormatMPEG4AAC),
                                    // 采样率
                                    AVSampleRateKey:@(11025.0),
                                    // 通道数
                                    AVNumberOfChannelsKey:@(2),
                                    // 录音质量
                                    AVEncoderAudioQualityKey:@(AVAudioQualityMin)
                                    };
        NSError *error = nil;
        self.recorder = [[AVAudioRecorder alloc]initWithURL:[NSURL fileURLWithPath:filePath] settings:configDic error:&error];
        if (error) {
            NSLog(@"error:%@",error);
        }
        // 准备录音(系统会给我们分配一些资源)
        [self.recorder prepareToRecord];
    }
    
    return self;
}

-(void)startRecording {
    NSLog(@"开始录音");
    [self.recorder record];
}

-(void)saveRecording {
    NSLog(@"保存录音");
    [self.recorder stop];
    AVAudioSession *session =[AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayback error:&sessionError];
}

- (void)pauseRecording{
    NSLog(@"暂停录音");
    [self.recorder pause];
}

- (void)resumeRecording{
    NSLog(@"恢复录音");
    [self.recorder record];
}

-(void)cancelCurrentRecording {
    NSLog(@"取消录音");
    [self.recorder stop];
    [self.recorder deleteRecording];
    AVAudioSession *session =[AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayback error:&sessionError];
}

#pragma mark - AVAudioRecorderDelegate
- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error{
    if (error) {
        NSLog(@"录音中出现错误:%@",error.localizedDescription);
    }
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    if (flag) {
        NSLog(@"录音完成");
    }
}

@end
