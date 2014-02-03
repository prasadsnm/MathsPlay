//
//  CountDownTimer.m
//  KidsLearningGame
//
//  Created by qainfotech on 05/10/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//

#import "CountDownTimer.h"

@implementation CountDownTimer
@synthesize myCounterLabel;
int hours, minutes, seconds;
int secondsLeft;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.myCounterLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        myCounterLabel.textAlignment=NSTextAlignmentCenter;
      //  myCounterLabel.backgroundColor=[UIColor colorWithRed:126/255.0 green:188/255.0 blue:74/255.0 alpha:1.0];
        myCounterLabel.backgroundColor=[UIColor clearColor];
        [self addSubview:myCounterLabel];
       
        
    }
    return self;
}





-(void)setMaxSecond:(double)sec
{
    secondsLeft = sec;

}


-(double)getSecondLeft
{
    return secondsLeft;

}
- (void)updateCounter:(NSTimer *)theTimer
{
        if (secondsLeft<20 && secondsLeft>0) {
        [myCounterLabel setHidden:![myCounterLabel isHidden]];
        myCounterLabel.textColor=[UIColor redColor];
    }
    
    if(secondsLeft > 0 )
    {
        secondsLeft -- ;
        hours = secondsLeft / 3600;
        minutes = (secondsLeft % 3600) / 60;
        seconds = (secondsLeft %3600) % 60;
        myCounterLabel.text = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
        myCounterLabel.font=[UIFont fontWithName:@"digital-7" size:40];
        myCounterLabel.textColor=[UIColor greenColor];

    }
    else{
        myCounterLabel.text=@"Time Up!!";
        [timer invalidate];
        [[self delegate]TimeUp];
    }
}

-(void)start{
    
    secondsLeft =hours = minutes = seconds = 0;   //reinitailizing second counter
    secondsLeft=[self getSecondLeft];

    if([timer isValid])
    {
        [timer invalidate];
        timer=nil;
    }
    @autoreleasepool {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
        
    }
}

-(void)pause
{

    if([timer isValid])
    {
        [timer invalidate];
        timer=nil;
    }
}

-(void)resume
{
    @autoreleasepool {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
        
    }


}

-(void)stop
{
    
    if([timer isValid])
    {
        [timer invalidate];
        timer=nil;
    }

}


@end
