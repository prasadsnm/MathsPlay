//
//  AddViewController.h
//  KidsLearningGame
//
//  Created by QA Infotech on 21/08/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface AddViewController : UIViewController
{
    NSMutableArray *questionArr, *arrOfOptions, *views;
    UITouch *touch;
    UIView *ansboxOne,*ansboxTwo,*circle,*firstCircle,*secondCircle;
    CGRect selectedOptionFrame; // to get the frame of the option cirlce that is selected
    CGRect firstOptionFrame, secondOptionFrame; // to get the frames of two option circle selected
    UILabel *correctAnsLabel, *inCorrectAnsLabel, *questionLabel, *timeUpdateLabel;
    UIButton *startButton;
    
    NSURL *wrongAnsUrl,*winAnsUrl;
    AVAudioPlayer *wrongAudioPlayer,*winAudioPlayer;
    NSTimer *clockTimer;
    
    // CONDITION CHECK VARIABLES
    BOOL isFirstRectFilled; // to check if the first box was filled or not ; Yes indicates first box
    BOOL isSecondRectFilled; // to check if the second box was filled or not ; Yes indicates second box
    NSInteger numberOfCircleDragged; // to check if the two boxes are filled or not
    NSInteger numberOfQuestionsAttempted;
    NSInteger correctAns, wrongAns, countdown, hintNumber;
    NSString *level;
}
@end
