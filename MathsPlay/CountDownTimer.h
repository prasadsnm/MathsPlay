//
//  CountDownTimer.h
//  KidsLearningGame
//
//  Created by qainfotech on 05/10/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CountDownTimerDelegate <NSObject>
-(void)TimeUp;
@end

@interface CountDownTimer : UIView
{
NSTimer *timer;
}
@property(nonatomic,strong)UILabel *myCounterLabel;
@property(unsafe_unretained,assign)id<CountDownTimerDelegate>delegate;
-(void)updateCounter:(NSTimer *)theTimer;
-(void)resume;
-(void)start;
-(void)pause;
-(void)stop;
-(void)setMaxSecond:(double)sec;
@end
