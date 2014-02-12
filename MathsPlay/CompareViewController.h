//
//  CompareViewController.h
//  KidsLearningGame
//
//  Created by QA Infotech on 10/07/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "CircularProgressView.h"

@interface CompareViewController : UIViewController
{
    UIImageView *backgroundImage;
    UIButton *numberBtn,*objectBtn,*greaterBtn,*equalBtn,*lesserBtn,*nextLevelBtn;
    UILabel *gameHeading,*leftNumberLbl,*rightNumberLbl,*totalAttempts,*rightAns,*wrongAns,*percentCompleted,*starEarnedLabel,*congratsLabelForFiveStars,*numberOfCorrectAnsLabel,*numberOfInCorrectAnsLabel, *nextLevelLabel;
    NSMutableDictionary *dic;
    UIImageView *star1,*star2,*star3,*star4,*star5;
    
    int totalattempts,rightans,wrongans;
    NSString *levelString;
    int objectsatleft , objectsatright,leftcounterobjects,rightcounterobjects;
    UIView *objectViewLeft,*objectViewRight;
    UILabel *leftLabel1,*leftLabel2,*leftLabel3,*leftLabel4,*leftLabel5,*leftLabel6,*leftLabel7,*leftLabel8,*leftLabel9,*leftLabel10,*leftLabel11,*leftLabel12,*leftLabel13,*leftLabel14,*leftLabel15,*leftLabel16,*leftLabel17,*leftLabel18;
    UILabel *rightLabel1,*rightLabel2,*rightLabel3,*rightLabel4,*rightLabel5,*rightLabel6,*rightLabel7,*rightLabel8,*rightLabel9,*rightLabel10,*rightLabel11,*rightLabel12,*rightLabel13,*rightLabel14,*rightLabel15,*rightLabel16,*rightLabel17,*rightLabel18;
    
    NSURL *wrongAnsUrl,*winAnsUrl;
    AVAudioPlayer *wrongAudioPlayer,*winAudioPlayer,*audioPlayerClap;
    NSError *error,*error2;
    NSTimer *timerForWinningStage;
    int timerStopValue;
    CircularProgressView *circularProgressView;
    UILabel *centerLabel,*levelTag,*chooseOperatorLabel;
}


@end
