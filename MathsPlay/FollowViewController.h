//
//  FollowViewController.h
//  KidsLearning
//
//  Created by QA Infotech on 23/07/12.
//  Copyright (c) 2012 ithelpdesk@qainfotech.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "MPCustomAlert.h"

@interface FollowViewController : UIViewController<UITextFieldDelegate,MPCustomAlertDelegate>
{
    NSMutableDictionary *dic;
    UILabel  *clockLabel , *equalToLabel, *nilValueLabel,*correctAnswerMessage,*timerLabel,*levelValue, *countDownToThreeLabel,*timeleftValue, *currentScoreLabel,*highScoreLabel,*level;
    UIButton *submitBtn;
    NSArray *arrayForNos , *arrayForOperators;
    int roundValue;
    UIView *alphaView, *zigzagView;
    UITextField *ansField;
    UIImageView *popupbox , *arrow ,*smiley, *water, *speechBubble;
    
    UIAlertView *levelpass, *levelfail, *hardLevelPass;
    UILabel *cheatCodeLabel;
    NSString *levelString;
    
    NSMutableArray *numberContainingArray;
    NSInteger finalAns;
    NSUInteger countdown, currentscore, highscore;
    AVAudioPlayer *countdownPlayer;
    NSTimer *countdownTimer;
}

@end
