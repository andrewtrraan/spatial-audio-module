//
//  ViewController.m
//  abstracted-avfoundation
//
//  Created by Andrew Tran on 2023-01-26.
//

#import "ViewController.h"
/*
@import AVFoundation;
#import <AVFoundation/AVAudioPlayer.h>
#import <AVFoundation/AVFoundation.h>
 */
#import <AVFoundation/AVFoundation.h>


@interface ViewController ()
@property (nonatomic, strong) AVAudioEngine *audioEngine;
@property (nonatomic, strong) AVAudioEnvironmentNode *audioEnvironmentNode;
@property (nonatomic, strong) AVAudioPlayerNode *audioPlayerNode;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
    AVAudioEngine *engine = [[AVAudioEngine alloc] init];

    //NSURL *soundURL = [NSURL fileURLWithPath:@"mixkit-clown-horn-at-circus-715.wav"];
    NSURL *soundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]
    pathForResource:@"mixkit-clown-horn-at-circus-715" ofType:@"wav"]];

    
    AVAudioPlayerNode *player = [[AVAudioPlayerNode alloc] init];
    [engine attachNode:player];
//[initWithContentsOfURL:soundFileURL error:&error];

    AVAudioUnitReverb *reverb = [[AVAudioUnitReverb alloc] init];
   // reverb.loadFactoryPreset(AVAudioUnitReverbPresetLargeHall);
    reverb.wetDryMix = 50;
    [engine attachNode:reverb];

    [engine connect:player to:reverb format:nil];
    [engine connect:reverb to:engine.mainMixerNode format:nil];

    AVAudioFile *file = [[AVAudioFile alloc] initForReading:soundURL error:nil];
    [player scheduleFile:file atTime:nil completionHandler:nil];

    [engine startAndReturnError:nil];
    [player play];

     */
    /*
    AVAudioEngine *engine = [[AVAudioEngine alloc] init];
    AVAudioPlayerNode *player = [[AVAudioPlayerNode alloc] init];

    NSURL *fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]
    pathForResource:@"mixkit-clown-horn-at-circus-715" ofType:@"wav"]];
    
    //NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"soundFile" withExtension:@"caf"];
    NSError *error;
    AVAudioFile *file = [[AVAudioFile alloc] initForReading:fileURL error:&error];

    [engine attachNode:player];
    [engine connect:player to:engine.mainMixerNode format:file.processingFormat];
    [engine startAndReturnError:nil];
    
    [player scheduleFile:file atTime:nil completionHandler:nil];
    [player play];
     */
    /*
    //plays sound but only with step
    NSString *path = [NSString stringWithFormat:@"%@/mixkit-clown-horn-at-circus-715.wav", [[NSBundle mainBundle] resourcePath] ];
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"mixkit-clown-horn-at-circus-715" ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath:path];

//    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
//    [audioSession setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionAllowBluetoothA2DP error:nil];
//   // [audioSession setMode:AVAudioSessionModeSpatial error:nil];
//    [audioSession setActive:YES error:nil];

    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
//    player.pan = 0.0;
//    player.volume = 100;
//    player.numberOfLoops = 0;
//    player.enableRate = YES;
//    player.rate = 1.0;
//    [player prepareToPlay];
        [player play];
     */
    
    /*
    NSString *path = [NSString stringWithFormat:@"%@/mixkit-clown-horn-at-circus-715.wav", [[NSBundle mainBundle] resourcePath] ];
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"mixkit-clown-horn-at-circus-715" ofType:@"wav"];
    NSURL *soundURL = [NSURL fileURLWithPath:path];
    AVAudioEngine *engine = [[AVAudioEngine alloc] init];
    AVAudioPlayerNode *player = [[AVAudioPlayerNode alloc] init];
    [engine attachNode:player];
    AVAudioEnvironmentNode *environment = [[AVAudioEnvironmentNode alloc] init];
    [engine attachNode:environment];
    [engine connect:player to:environment format:[engine inputFormatForNode:player]];

    AVAudioFile *file = [[AVAudioFile alloc] initForReading:soundURL error:nil];

    [engine startAndReturnError:nil];
    player.position = (AVAudio3DPoint){10, 0, 0};
    [player scheduleFile:file atTime:nil completionHandler:nil];
    [player play];
*/


    // 1. Set up AVAudioEngine
    self.audioEngine = [[AVAudioEngine alloc] init];
    
    // 2. Create audio environment node
    self.audioEnvironmentNode = [[AVAudioEnvironmentNode alloc] init];
    [self.audioEngine attachNode:self.audioEnvironmentNode];
    
    // 3. Connect environment node to main mixer
    AVAudioMixerNode *mainMixer = [self.audioEngine mainMixerNode];
    
    AVAudioFormat *outputFormat = [mainMixer outputFormatForBus:0];
    [self.audioEngine connect:self.audioEnvironmentNode to:mainMixer format:outputFormat];
    /*
    [self.audioEngine connect:self.audioEnvironmentNode to:mainMixer format:mainMixer.outputFormat];
    */
    
    // 4. Create audio player node
    self.audioPlayerNode = [[AVAudioPlayerNode alloc] init];
    [self.audioEngine attachNode:self.audioPlayerNode];
    
    
    // 5. Connect audio player node to environment node
    AVAudioFormat *inputFormat = [self.audioEnvironmentNode inputFormatForBus:0];
    [self.audioEngine connect:self.audioPlayerNode to:self.audioEnvironmentNode format:inputFormat];
//
//    [self.audioEngine connect:self.audioPlayerNode to:self.audioEnvironmentNode format:self.audioEnvironmentNode.inputFormatForBus:0];
     
    
    
    // 6. Load audio file
    NSURL *audioFileURL = [[NSBundle mainBundle] URLForResource:@"mixkit-clown-horn-at-circus-715" withExtension:@"wav"];
    AVAudioFile *audioFile = [[AVAudioFile alloc] initForReading:audioFileURL error:nil];
    
    // 7. Schedule the audio file to play
    [self.audioPlayerNode scheduleFile:audioFile atTime:nil completionHandler:nil];
    
    // 8. Start the audio engine
    [self.audioEngine startAndReturnError:nil];
    
    // 9. Play the audio file
    [self.audioPlayerNode play];
    
    // 10. Set the position and orientation of the audio player node
    self.audioPlayerNode.position = AVAudioMake3DPoint(1.0, 0.0, 0.0);
    
    
    //self.audioPlayerNode.orientation = AVAudioMake3DVector(0.0, 1.0, 0.0);
    self.audioPlayerNode.reverbBlend = 0.5;
    
    

    
//    // 10. Set the position and orientation of the audio player node
//    self.audioPlayerNode.position = AVAudioMake3DPoint(1.0, 0.0, 0.0);
//
//
//    //self.audioPlayerNode.orientation = AVAudioMake3DVector(0.0, 1.0, 0.0);
//    self.audioPlayerNode.reverbBlend = 0.5;
//    // 7. Schedule the audio file to play
//    [self.audioPlayerNode scheduleFile:audioFile atTime:nil completionHandler:nil];
//    // 9. Play the audio file
//    [self.audioPlayerNode play];
    

    

    
    
    
    



}


@end

