//
//  CustomAudioToolBox.h
//  KidsLearningGame
//
//  Created by qainfotech on 29/10/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface CustomAudioToolBox : NSObject
{
SystemSoundID soundClick;
}
-(void)playSound:(NSString *)soundName withExtension:(NSString *)extension;
-(void)dispose;
@property(nonatomic,weak)NSURL *clickSound;
@end
