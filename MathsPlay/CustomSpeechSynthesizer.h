//
//  CustomSpeechSynthesizer.h
//  MathsPlay
//
//  Created by qainfotech on 17/02/14.
//  Copyright (c) 2014 qainfotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface CustomSpeechSynthesizer : NSObject
-(void)speakText:(NSString *)textToSpeak;
@end
