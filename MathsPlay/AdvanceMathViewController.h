//
//  AdvanceMathViewController.h
//  KidsLearning
//
//  Created by QA Infotech on 10/10/12.
//  Copyright (c) 2012 ithelpdesk@qainfotech.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>

@interface AdvanceMathViewController : UIViewController
{
    UIView *viewForBackgroundImage , *resultView , *finishLineView;
    UIImageView *backgroundImage, *finishLine1, *finishLine2, *finishLine3, *finishLine4;
    
    UIView *trackView1, *trackView2, *trackView3, *trackView4;
    
    NSTimer *carTimer1, *carTimer2, *carTimer3, *carTimer4 ;
    UILabel *mulQuestion, *resultViewLabel;
    int a1 , a2 , questionValue;
    int b1,b2,d1,d2,e1,e2;
    float c1 , c2 , c3 ,c4;
    int flag1,flag2,flag3,flag4,randomNumberOne;
    UIButton *option1 , *option2 , *option3 , *option4;
    UIImageView *buttonImage1, *buttonImage2 , *buttonImage3 , *buttonImage4;
    UILabel *buttonLabel1, *buttonLabel2, *buttonLabel3, *buttonLabel4 , *randomLabel;
    NSArray *optionNumberLabelArray;
    AVAudioPlayer *audioPlayer, *audioPlayerClap;
    
    
    NSString *modeValue , *levelName;
    UIImageView *raceBackgroundImage1,*raceBackgroundImage2 , *raceBackgroundImage3,*carImage1,*carImage2,*carImage3,*carImage4;
    NSTimer  *countDownTimer;
    int x , y , t, i , j , k ,l , countDownTimerVariable , z , u,v ;
    UIButton *playButton;
    NSDictionary *dic;
    
}

@property(nonatomic,copy) NSString *modeValue;
-(void)randomQuestionAndAnswer;
@end
