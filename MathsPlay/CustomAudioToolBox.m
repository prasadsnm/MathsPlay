//
//  CustomAudioToolBox.m
//  KidsLearningGame
//
//  Created by qainfotech on 29/10/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//

#import "CustomAudioToolBox.h"

@implementation CustomAudioToolBox
-(void)playSound:(NSString *)soundName withExtension:(NSString *)extension;
{
    NSURL *clickSound   = [[NSBundle mainBundle] URLForResource:soundName withExtension:extension];
    //initialize SystemSounID variable with file URL
    AudioServicesCreateSystemSoundID (CFBridgingRetain(clickSound), &soundClick);
    AudioServicesPlaySystemSound(soundClick);
    
}
-(void)dispose
{
    AudioServicesDisposeSystemSoundID(soundClick);

}
@end
