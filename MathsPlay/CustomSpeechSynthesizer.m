//
//  CustomSpeechSynthesizer.m
//  MathsPlay
//
//  Created by qainfotech on 17/02/14.
//  Copyright (c) 2014 qainfotech. All rights reserved.
//

#import "CustomSpeechSynthesizer.h"

@implementation CustomSpeechSynthesizer

-(void)speakText:(NSString *)textToSpeak
{
   AVSpeechUtterance *utterance = [AVSpeechUtterance
                                    speechUtteranceWithString:textToSpeak];
    
    
    // NSLog(@"%@",[AVSpeechSynthesisVoice speechVoices]);
    
    
    //    [utterance setVolume:1.0];
    [utterance setRate:0.3];
    
    // [utterance setVoice:[[AVSpeechSynthesisVoice speechVoices] objectAtIndex:11]];
    
    [utterance setShouldGroupAccessibilityChildren:YES];
    AVSpeechSynthesizer *synth = [[AVSpeechSynthesizer alloc] init];
    [synth speakUtterance:utterance];

}
@end
