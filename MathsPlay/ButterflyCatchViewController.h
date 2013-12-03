//
//  ButterflyCatchViewController.h
//  MathsPlay
//
//  Created by qainfotech on 11/12/13.
//  Copyright (c) 2013 qainfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface ButterflyCatchViewController : UIViewController
{
    UILabel  *greetingsLabel, *messageLabel, *numberLabel1,*numberLabel2,*numberLabel3,*numberLabel4,*numberLabel5,*numberLabel6, *journeyLabel;
    NSMutableDictionary *dic;
    UIImageView *avatarImage,*orangeImage1,*orangeImage2,*orangeImage3,*orangeImage4,*orangeImage5,*orangeImage6;
    NSInteger  randomnumber,value2,value3,value4,value5,value6,number1hide,number2hide,number3hide,optionframe1value,optionframe2value,optionframe3value,optionframe4value,optionframe5value,optionframe6value;
    UIView *optionView1,*optionView2,*optionView3,*optionView4,*optionView5,*optionView6;
    UIImageView *optionImage1, *optionImage2,*optionImage3, *optionImage4, *optionImage5, *optionImage6,*image1Show,*image2Show,*image3Show;
    UILabel *optionLabel1, *optionLabel2, *optionLabel3, *optionLabel4, *optionLabel5, *optionLabel6,*label1Hide,*label2Hide,*label3Hide;
    UITouch *touch;
    CGRect originalFrameOfOptionView1,originalFrameOfOptionView2,originalFrameOfOptionView3,originalFrameOfOptionView4,originalFrameOfOptionView5,originalFrameOfOptionView6;
    NSURL *wrongAnsUrl,*winAnsUrl;
    AVAudioPlayer *wrongAudioPlayer,*winAudioPlayer;
    NSError *error,*error2;
    CGRect rect1, rect2, rect3;
    NSString *bubbleNumber; // whether it is simple counting or reverse counting
    UIButton *nextLevelButton;
    NSTimer *timerForWinningStage,*timerForLabelMarquee;
    UILabel *cheers;
    AVAudioPlayer *audioPlayerClap;
    int timerStopValue; // if timer is on den value is 1 and if 1 den on bak btn press invalidate the timer
    
    NSTimer *butterfly1, *butterfly2, *butterfly3, *butterfly4, *butterfly5, *butterfly6;
}

-(void)showRandomValues;
-(int)getRandomNumber:(int)from to:(int)to ;

@property(nonatomic,copy) NSString *bubbleNumber;

@end